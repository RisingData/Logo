import java.util.Vector;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.TimeZone;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.ByteArrayOutputStream;
import java.util.Date;

class SystemPrims extends Primitives {

  static String[] primlist={
    "resett", "0",
    "timer", "0",
    "eq", "2",
    "(", "0",
    ")", "0",
    "wait", "1",
    "true", "0",
    "false", "0",
    "hexw", "2",
    "octw", "2",
    "decw", "2",
    "tab", "0",
    "classof", "1",
    "class", "1",
    "string", "1",
    "%nothing%", "0",
    "cprint", "1",
    "print", "1",
    "printc", "1",
    "hexparse", "1",
    "scanhex", "3",
    "exec", "1",
    "blindexec", "1",
    "berecv", "0",
    "besend", "1",
    "getproperty", "1",
    "ignore", "1",
    "qsym", "1",
    "now", "0",
    "dateformat", "3",
    "dateparse", "2",
    "exit", "0",
    "clarg", "1",
    "setindent", "1",
    "sethandleline", "1",
    "octal", "0",
    "decimal", "0",
    "ask", "1",
    "answer", "0"
  };

  public String[] primlist(){return primlist;}
  BufferedReader input = new BufferedReader(new InputStreamReader(System.in));

  public Object dispatch(int offset, Object[] args, LContext lc){
    switch(offset){
      case 0: return prim_resett(lc);
      case 1: return prim_timer(lc);
      case 2: return prim_eq(args[0], args[1], lc);
      case 3: return prim_parleft(lc);
      case 4: return prim_parright(lc);
      case 5: return prim_wait(args[0], lc);
      case 6: return prim_true(lc);
      case 7: return prim_false(lc);
      case 8: return prim_hexw(args[0], args[1], lc);
      case 9: return prim_octw(args[0], args[1], lc);
      case 10: return prim_decw(args[0], args[1], lc);
      case 11: return prim_tab(lc);
      case 12: return prim_classof(args[0], lc);
      case 13: return prim_class(args[0], lc);
      case 14: return prim_string(args[0], lc);
      case 15: return new Nothing();
      case 16: System.out.println(Logo.prs(args[0])); return null;
      case 17: StdioJL.println(Logo.prs(args[0])); return null;
      case 18: System.out.print(Logo.prs(args[0])); return null;
      case 19: return prim_hexparse(args[0], lc);
      case 20: return prim_scanhex(args[0], args[1], args[2], lc);
      case 21: return prim_exec(args[0], lc);
      case 22: return prim_blindexec(args[0], lc);
      case 23: return prim_berecv(lc);
      case 24: return prim_besend(args[0], lc);
      case 25: return prim_getProperty(args[0], lc);
      case 26: return null;   // ignore
      case 27: return prim_qsym(args[0], lc);
      case 28: return prim_now(lc);
      case 29: return prim_dateformat(args[0], args[1], args[2], lc);
      case 30: return prim_dateparse(args[0], args[1], lc);
      case 31: System.exit(0); return null;
      case 32: return prim_clarg(args[0], lc);
      case 33: lc.indent = Logo.prs(args[0]); return null;
      case 34: lc.handleLine = Logo.aBoolean(args[0], lc); return null;
      case 35: Logo.base=8; return null;
      case 36: Logo.base=10; return null;
      case 37: return prim_ask(args[0], lc);
      case 38: return lc.answer;
    }
    return null;
  }

  Object prim_resett(LContext lc){
    Logo.starttime=System.currentTimeMillis();
    return null;
  }

  Object prim_timer(LContext lc){
    return new Double(System.currentTimeMillis()-Logo.starttime);
  }

  Object prim_eq(Object arg1, Object arg2, LContext lc){
    return new Boolean(arg1.equals(arg2));
  }

  Object prim_parright(LContext lc){
    Logo.error("Missing \"(\"", lc);
    return null;
  }

  Object prim_parleft(LContext lc){
    if (ipmnext(lc.iline)) return ipmcall(lc);
    Object arg=Logo.eval(lc), next=lc.iline.next();
    if ((next instanceof Symbol) &&
        ((Symbol) next).pname.equals(")"))
      return arg;
    Logo.error("Missing \")\"", lc);
    return null;
  }

  boolean ipmnext(MapList iline){
    try { return ((Symbol)iline.peek()).fcn.ipm;}
    catch (Exception e) {return false;}
  }

  Object ipmcall(LContext lc){
    Vector<Object> v=new Vector<Object>();
    lc.cfun=(Symbol) lc.iline.next();
    while(!finIpm(lc.iline))
      v.addElement(Logo.evalOneArg(lc.iline, lc));
    Object[] o=new Object[v.size()];
    v.copyInto(o);
    return Logo.evalSym(lc.cfun, o, lc);
  }

  boolean finIpm(MapList l){
    if (l.eof()) return true;
    Object next=l.peek();
    if ((next instanceof Symbol) &&
        ((Symbol) next).pname.equals(")"))
      {l.next();return true;}
    return false;
  }

  Object prim_wait(Object arg1, LContext lc){
    double d=10*Logo.aDouble(arg1, lc);
    int n = (int)d;
    for(int i=0;i<n;i++){
     if(lc.timeToStop) return null;
/* this new line removed because it broke blindexec
     if (lc.timeToStop) {lc.timeToStop=false; Logo.error("", lc);}
*/
     try{Thread.sleep(10);}
     catch(InterruptedException e){};
    }
    return null;
  }

  Object prim_hexw(Object arg1, Object arg2, LContext lc){
    String s = Logo.prs(0xffffffffL&Logo.aLong(arg1, lc), 16);
    int len = Logo.anInt(arg2, lc);
    if(len==0) return s;
    String pad = "00000000".substring(8-len+s.length());
    return pad+s;
  }

  Object prim_octw(Object arg1, Object arg2, LContext lc){
    Logo.anInt(arg1, lc);
    String s = Logo.prs(arg1, 8);
    int len = Logo.anInt(arg2, lc);
    if(len==0) return s;
    String pad = "0000000000000000".substring(16-len+s.length());
    return pad+s;
  }

  Object prim_decw(Object arg1, Object arg2, LContext lc){
    Logo.anInt(arg1, lc);
    String s = Logo.prs(arg1, 10);
    int len = Logo.anInt(arg2, lc);
    if(len==0) return s;
    String pad = "0000000000000000".substring(16-len+s.length());
    return pad+s;
  }

  Object prim_true(LContext lc){return new Boolean(true);}
  Object prim_false(LContext lc){return new Boolean(false);}
  Object prim_tab(LContext lc){return "\t";}

  Object prim_classof(Object arg1, LContext lc){
    return arg1.getClass();
  }

  Object prim_class(Object arg1, LContext lc){
    try {return Class.forName(Logo.prs(arg1));}
    catch (Exception e) {return "";}
    catch (Error e) {return "";}
  }

  Object prim_string(Object arg1, LContext lc){
    if(arg1 instanceof byte[]) return new String((byte[])arg1);
    return prstring (arg1);
  }


  String prstring(Object l) {
    if(l instanceof Number && Logo.isInt((Number)l))
       return Long.toString(((Number)l).longValue(), 10);
    if(l instanceof String) return "|"+((String)l)+"|";
    if(l instanceof Object[]){
       String str="";
       Object[] ll= (Object[])l;
       for(int i=0;i<ll.length;i++){
           if(ll[i] instanceof Object[]) str +="[";
           str+=prstring(ll[i]);
           if(ll[i] instanceof Object[])str+="]";
           if (i!=ll.length-1)str+=" ";
          }
       return str;
      }
    return l.toString();
  }

  Object prim_hexparse(Object arg1, LContext lc){
    TokenStream ts = new TokenStream(Logo.prs(arg1), true);
    return ts.readList(lc);
  }

  Object prim_scanhex(Object arg1, Object arg2, Object arg3, LContext lc){
    String input = (String) arg1;
    Object[] result = (Object[]) arg2;
    Object[] format = (Object[]) arg3;
    for(int i=0;i<result.length;i++){
      int start = ((Number)format[i*2]).intValue();
      int end = ((Number)format[i*2+1]).intValue()+start;
      String str = input.substring(start, end);
      result[i]=new Long(Long.parseLong(str, 16));
    }
    return null;
  }

  Object prim_exec(Object arg1, LContext lc){
    String cmd = Logo.prs(arg1),s, res="";
    try {
     Process p = Runtime.getRuntime().exec(cmd);
     BufferedReader br1 = new BufferedReader(new InputStreamReader(p.getInputStream()));
     BufferedReader br2 = new BufferedReader(new InputStreamReader(p.getErrorStream()));
     while ((s = br1.readLine()) != null) res=res+s+"\n";
     while ((s = br2.readLine()) != null) res=res+s+"\n";
    } catch (Exception e) {Logo.error("exec: "+e+" "+cmd, lc);}
    return res;
  }

  Process bep;
  BufferedReader bebr;
  BufferedReader bebre;

/*
 comment out brian's new version - will be added later under a new name
  Object prim_blindexec(Object arg1, LContext lc){
    String cmd = Logo.prs(arg1);
    if(processRunning(bep)) bep.destroy();
    bep = null;
    bebr = bebre = null;
    if(cmd.equals("")) return null;
    try {
      bep = Runtime.getRuntime().exec(cmd);
      bebr = new BufferedReader(new InputStreamReader(bep.getInputStream()));
      bebre = new BufferedReader(new InputStreamReader(bep.getErrorStream()));
    } catch (Exception e) {Logo.error("exec: "+e+" "+cmd, lc);}
    return null;
  }
*/

/* older version of blindexec */
 Object prim_blindexec(Object arg1, LContext lc){
    String cmd = Logo.prs(arg1),s, res="";
    try {
     Process p = Runtime.getRuntime().exec(cmd);
    } catch (Exception e) {Logo.error("exec: "+e+" "+cmd, lc);}
    return null;
  }

  Object prim_berecv(LContext lc){
    try {
      if(bebr.ready()) return new Double(bebr.read());
      if(bebre.ready()) return new Double(bebre.read());
      if(!processRunning(bep)) return new Object[0];
      return new Double(-1);
    }
    catch (Exception e) {Logo.error("bereadline: "+e, lc);}
    return null;
  }

  Object prim_besend(Object arg1, LContext lc){
    try{
      if(arg1 instanceof byte[]) bep.getOutputStream().write((byte[])arg1);
      else if(arg1 instanceof String) bep.getOutputStream().write(((String)arg1).getBytes());
      else if(arg1 instanceof Symbol) bep.getOutputStream().write(arg1.toString().getBytes());
      else bep.getOutputStream().write(Logo.anInt(arg1, lc));
      bep.getOutputStream().flush();}
    catch (Exception e) {Logo.error("besend error: " + e, lc);}
    return null;
  }

  boolean processRunning(Process p){
    if(p==null) return false;
    try{p.exitValue();}
    catch(Exception e) {return true;}
    return false;
  }

  Object prim_getProperty(Object arg1, LContext lc){
    String res = System.getProperty(Logo.prs(arg1));
    if(res == null) return "";
    return res;
  }

  Object prim_qsym(Object arg1, LContext lc){
    return new QuotedSymbol(Logo.aSymbol(arg1,lc));
  }

  Object prim_now(LContext lc){
    return new Double((new Date()).getTime());
  }

  Object prim_dateformat(Object arg1, Object arg2, Object arg3, LContext lc){
    String format = Logo.prs(arg1);
    long time = Logo.aLong(arg2, lc);
    TimeZone timezone = TimeZone.getTimeZone(Logo.prs(arg3));
    SimpleDateFormat sdf = new SimpleDateFormat(format);
    sdf.setTimeZone(timezone);
    return sdf.format(new Date(time));
  }

  Object prim_dateparse(Object arg1, Object arg2, LContext lc){
    String pattern= Logo.prs(arg1), datestring = Logo.prs(arg2);
    try { return new Long((new SimpleDateFormat(pattern)).parse(datestring).getTime());}
    catch (ParseException e) {//Logo.error("can't parse date:"+datestring, lc);//
    }
    Logo.error("can't parse date:"+datestring, lc);
    return "null";
   }

  Object prim_clarg(Object arg1, LContext lc){
    int argn = Logo.anInt(arg1,lc);
    if(argn<lc.clargs.length) return lc.clargs[argn];
    else return new Object[0];
  }

  Object prim_ask(Object arg1, LContext lc){
    System.out.print(Logo.prs(arg1));
    lc.asking = true;
    lc.answer = "";
    while(true){
     if(lc.timeToStop) break;
     if(!lc.asking) return null;
     try{Thread.sleep(10);}
     catch(InterruptedException e){};
    }
    lc.asking = false;
    return null;
  }
}
