package com.hnqj.core;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Random;

/**
 * Created by wangyong on 2016/11/23.
 */
public class GeneratorTools {
    private String packageName = "com.hnqj";
    private String pageData = "PageData pageData";
    private String page = "pageData";
    private String pa = ",";


    private String path = "I:\\chinaweb\\src\\main\\java\\com\\hnqj";

    private void getServiceImpl(String bean) {
            String service = bean + "Services";
            String stradd=""+bean+"Mapper.add"+bean+"";
            String str1delete=""+bean+"Mapper.delete"+bean+"ByFid";
            String str1update=""+bean+"Mapper.update"+bean+"";
            String str1select=""+bean+"Mapper.getAll"+bean+"";
            String str1select1=""+bean+"Mapper.select"+bean+"List";
            String str1select2=""+bean+"Mapper.get"+bean+"ForId";
            StringBuffer sb = new StringBuffer();
            sb.append("package " + packageName + ".services;\n\n");
            sb.append("import " + packageName + ".core.PageData;\n\n");
            sb.append("import " + packageName + ".model."+bean+";\n\n");
            sb.append("import " + "javax.annotation.Resource" + ";\n");
            sb.append("import " + packageName + ".dao.DaoSupportImpl"+";\n");
            sb.append("import org.springframework.stereotype.Service;\n");
            sb.append("import org.apache.commons.logging.Log;\n");
            sb.append("import org.apache.commons.logging.LogFactory;\n");

            sb.append("import java.util.List;\n");
            sb.append("@Service(\""+bean.toLowerCase()+"\")\n");
            sb.append("public class " + service +" {\n\n");
            sb.append("protected final Log logger = LogFactory.getLog(getClass());\n\n");
            sb.append("\t@Resource(name = \"daoSupportImpl\")\n\n");
            sb.append("\tprivate DaoSupportImpl daoSupport; \n\n");

            sb.append("\tpublic int add"+bean+"(" +pageData+ ") {\n");
            sb.append("\t logger.info(\"增加"+bean+"\");\n");
            sb.append("\t int iFlag =0; \n");
            sb.append("\t try { \n");
            sb.append("\t\tiFlag = (int) daoSupport.insert(\""+stradd+"\""+pa+""+page+");\n");
            sb.append("\t }catch (Exception e){ \n");
            sb.append("\t e.printStackTrace(); \n");
            sb.append("\t iFlag=0; \n");
            sb.append("\t}\n");
            sb.append("\t return iFlag; \n");
            sb.append("\t}\n");


            sb.append("\tpublic int del"+bean+"ByFid(String fid) {\n");
            sb.append("\t logger.info(\"删除"+bean+"\");\n");
            sb.append("\t int iFlag =0; \n");
            sb.append("\t try { \n");
            sb.append("\t\tiFlag = (int) daoSupport.delete(\""+str1delete+"\""+pa+"fid);\n");
            sb.append("\t }catch (Exception e){ \n");
            sb.append("\t e.printStackTrace(); \n");
            sb.append("\t iFlag=0; \n");
            sb.append("\t}\n");
            sb.append("\t return iFlag; \n");
            sb.append("\t}\n");

            sb.append("\tpublic int update"+bean+"(" + pageData + ") {\n");
            sb.append("\t logger.info(\"修改"+bean+"\");\n");
            sb.append("\t int iFlag =0; \n");
            sb.append("\t try { \n");
            sb.append("\t\tiFlag = (int) daoSupport.update(\""+str1update+"\""+pa+""+page+");\n");
            sb.append("\t }catch (Exception e){ \n");
            sb.append("\t e.printStackTrace(); \n");
            sb.append("\t iFlag=0; \n");
            sb.append("\t}\n");
            sb.append("\t return iFlag; \n");
            sb.append("\t}\n");


            sb.append("\tpublic "+bean +" get"+bean+"forId(String fid) {\n");
            sb.append("\t logger.info(\"通过ID查询"+bean+"\");\n");
            sb.append("\t"+bean+"\t"+bean.toLowerCase()+"=null;\n");
            sb.append("\t try { \n");
            sb.append("\t\t"+bean.toLowerCase()+" = ("+bean+") daoSupport.findForObject(\""+str1select2+"\""+pa+"fid);\n");
            sb.append("\t }catch (Exception e){ \n");
            sb.append("\t e.printStackTrace(); \n");
            sb.append("\t "+bean.toLowerCase()+"=null; \n");
            sb.append("\t}\n");
            sb.append("\t return "+bean.toLowerCase()+"; \n");
            sb.append("\t}\n");


            sb.append("\tpublic List<"+bean +"> getAll"+bean+"(" + pageData + ") {\n");
            sb.append("\t logger.info(\"分页查询"+bean+"\");\n");
            sb.append("\tList<"+bean+">\t"+bean.toLowerCase()+"List=null;\n");
            sb.append("\t try { \n");
            sb.append("\t\t"+bean.toLowerCase()+"List = (List<"+bean+">) daoSupport.findForList(\""+str1select+"\""+pa+""+page+");\n");
            sb.append("\t }catch (Exception e){ \n");
            sb.append("\t e.printStackTrace(); \n");
            sb.append("\t "+bean.toLowerCase()+"List=null; \n");
            sb.append("\t}\n");
            sb.append("\t return "+bean.toLowerCase()+"List; \n");
            sb.append("\t}\n");



            sb.append("\tpublic List<"+bean +"> select"+bean+"List() {\n");
            sb.append("\t logger.info(\"查询所有"+bean+"\");\n");
            sb.append("\tList<"+bean+">\t"+bean.toLowerCase()+"List=null;\n");
            sb.append("\t try { \n");
            sb.append("\t\t"+bean.toLowerCase()+"List = (List<"+bean+">) daoSupport.findForList(\""+str1select1+"\""+pa+"null);\n");
            sb.append("\t }catch (Exception e){ \n");
            sb.append("\t e.printStackTrace(); \n");
            sb.append("\t "+bean.toLowerCase()+"List=null; \n");
            sb.append("\t}\n");
            sb.append("\t return "+bean.toLowerCase()+"List; \n");
            sb.append("\t}\n");
            sb.append("}\n");
        outputToFile(path+"\\services\\"+service+".java", sb.toString());
    }


    private void outputToFile(String fileName, String content) {
        OutputStream os = null;
        try {
            os = new FileOutputStream(fileName);
        } catch (FileNotFoundException e1) {
            e1.printStackTrace();
        }
        byte[] b = content.getBytes();
        try {
            os.write(b);
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                os.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] agrs) {
        //GeneratorTools generator= new GeneratorTools();
        /*
        generator.getServiceImpl("Account");
        generator.getServiceImpl("Advert");
        generator.getServiceImpl("Cashrecord");
        generator.getServiceImpl("Changelog");
        generator.getServiceImpl("Client");
        generator.getServiceImpl("Collection");
        generator.getServiceImpl("Comment");
        generator.getServiceImpl("Dealrecord");
        generator.getServiceImpl("Dealuidchild");
        generator.getServiceImpl("Dict");
        generator.getServiceImpl("Distribution");
        generator.getServiceImpl("Distrirecord");
        generator.getServiceImpl("Findimg");
        generator.getServiceImpl("FocusOther");
        generator.getServiceImpl("Groomapply");
        generator.getServiceImpl("Integral");
        generator.getServiceImpl("Leavemsg");
        generator.getServiceImpl("Limit");
        generator.getServiceImpl("Merchcycle");
        generator.getServiceImpl("Merchdown");
        generator.getServiceImpl("Notify");
        generator.getServiceImpl("Playimg");
        generator.getServiceImpl("Proportions");
        generator.getServiceImpl("Props");
        generator.getServiceImpl("PropsImage");
        generator.getServiceImpl("Releaseadvert");
        generator.getServiceImpl("Shoppingcart");
        generator.getServiceImpl("Sysconfig");
        generator.getServiceImpl("Syslog");
        generator.getServiceImpl("Template");
        generator.getServiceImpl("Train");
        generator.getServiceImpl("Unsubscribe");
        generator.getServiceImpl("Userlevel");
        generator.getServiceImpl("Worklabel");
        generator.getServiceImpl("Works");
        generator.getServiceImpl("Userinfo");
        */
        //generator.getServiceImpl("Download");
        BufferedReader in = null;
        try {
            //(int)((Math.random()*9+1)*100000));
            //六位随机数100000--999999
            int flag = new Random().nextInt(999999);
            if (flag < 100000) {
                flag += 100000;
            }
            String content = "【婚秀网】短信验证码：" + flag;
            StringBuffer sb = new StringBuffer("http://sms-cly.cn/smsSend.do?");
            sb.append("username=clyhxkj");
            sb.append("&password=f6f5696da081db645bb4ddec96663f70");
            sb.append("&mobile=17603889885");
            sb.append("&content="+ URLEncoder.encode(content,"utf-8"));
            //sb.append("&dstime=");
            URL url = new URL(sb.toString());
            URLConnection conn = url.openConnection();
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.connect();
            in = new BufferedReader(new InputStreamReader(url.openStream()));
            //读取返回参数
            String result = in.readLine();
            long lnid = Long.valueOf(result);

            in.close();
            System.out.println("rtnVal:"+lnid+"      randomNum:"+flag);
        }catch (Exception e){
        }
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
