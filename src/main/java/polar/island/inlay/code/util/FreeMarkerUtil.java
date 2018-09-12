package polar.island.inlay.code.util;

import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.ibatis.javassist.tools.reflect.CannotCreateException;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import polar.island.core.util.PropertieUtil;
import polar.island.inlay.code.entity.CodeEntity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

public class FreeMarkerUtil {
    private static final String CHAR_SET = "UTF-8";

    public FreeMarkerUtil() {

    }

    private static void write(Configuration cfg, String ftlName, Map<String, Object> data, String destFilePath)
            throws Exception {
        File destFile = new File(destFilePath);
        generateFloder(destFile.getParent());
        if (!destFile.exists()) {
            boolean flag = destFile.createNewFile();
            if (!flag) {
                throw new CannotCreateException("文件无法被创建");
            }
        }
        Template template = cfg.getTemplate(ftlName, CHAR_SET);
        template.setEncoding(CHAR_SET);
        Writer out = new OutputStreamWriter(new FileOutputStream(destFilePath), CHAR_SET);
        template.process(data, out);
        out.flush();
        out.close();
    }

    public static void genChildCode(Map<String, Object> data, String folderName) throws Exception {
        Configuration cfg = new Configuration();
        CodeEntity entity = (CodeEntity) data.get("code");
        CodeEntity parent = (CodeEntity) ((Map<String, Object>)data.get("parent")).get("code");
        Resource path = new DefaultResourceLoader().getResource("classpath:/");
        cfg.setDirectoryForTemplateLoading(new File(path.getFile(), "template/" + folderName));
        cfg.setURLEscapingCharset(CHAR_SET);
        cfg.setDefaultEncoding(CHAR_SET);
        // 开始写入mapper文件
        String mapperPath = PropertieUtil.getSetting("CODE_PATH") + "/resources/mapping/modules/" + entity.getMapperFloderName() + "/"
                + entity.getMapperFileName() + ".xml";
        // 生成Mapper文件
        write(cfg, "mapper.ftl", data, mapperPath);
        // 生成dao文件
        String packageName = entity.getPackageName().replace(".", "/");
        String daoPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/dao/"
                + entity.getDaoName() + ".java";
        write(cfg, "dao.ftl", data, daoPath);

        // 生成实体
        String entityPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/entity/"
                + entity.getEntityName() + ".java";
        write(cfg, "entity.ftl", data, entityPath);

        String formPath = PropertieUtil.getSetting("CODE_PATH") + "/webapp/view/modules/" + parent.getModuleName() + "/"
                + entity.getJspEditName() + ".jsp";
        write(cfg, "form.ftl", data, formPath);
    }

    public static String genCode(Map<String, Object> data, String folderName) throws Exception {
        Configuration cfg = new Configuration();
        CodeEntity entity = (CodeEntity) data.get("code");
        Resource path = new DefaultResourceLoader().getResource("classpath:/");
        cfg.setDirectoryForTemplateLoading(new File(path.getFile(), "template/" + folderName));
        cfg.setURLEscapingCharset(CHAR_SET);
        cfg.setDefaultEncoding(CHAR_SET);
        // 开始写入mapper文件
        String mapperPath = PropertieUtil.getSetting("CODE_PATH") + "/resources/mapping/modules/" + entity.getMapperFloderName() + "/"
                + entity.getMapperFileName() + ".xml";
        // 生成Mapper文件
        write(cfg, "mapper.ftl", data, mapperPath);
        // 生成dao文件
        String packageName = entity.getPackageName().replace(".", "/");
        String daoPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/dao/"
                + entity.getDaoName() + ".java";
        write(cfg, "dao.ftl", data, daoPath);
        // 生成服务类
        String servicePath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/service/"
                + entity.getServiceName() + ".java";
        write(cfg, "service.ftl", data, servicePath);
        // 生成服务类实现类
        String serviceImplPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName()
                + "/service/" + entity.getServiceImplName() + ".java";
        write(cfg, "serviceImpl.ftl", data, serviceImplPath);
        // 生成实体
        String entityPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/entity/"
                + entity.getEntityName() + ".java";
        write(cfg, "entity.ftl", data, entityPath);

        String webPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/web/"
                + entity.getControllerWebName() + ".java";
        write(cfg, "web.ftl", data, webPath);
        String jsonbPath = PropertieUtil.getSetting("CODE_PATH") + "/java/" + packageName + "/" + entity.getModuleName() + "/web/"
                + entity.getControllerJsonName() + ".java";
        write(cfg, "json.ftl", data, jsonbPath);
        String listPath = PropertieUtil.getSetting("CODE_PATH") + "/webapp/view/modules/" + entity.getModuleName() + "/"
                + entity.getJspListName() + ".jsp";
        write(cfg, "list.ftl", data, listPath);
        String formPath = PropertieUtil.getSetting("CODE_PATH") + "/webapp/view/modules/" + entity.getModuleName() + "/"
                + entity.getJspEditName() + ".jsp";
        write(cfg, "form.ftl", data, formPath);
        String str = daoPath + "\r\n" + servicePath + "\r\n" + serviceImplPath + "\r\n" + entityPath + "\r\n" + webPath
                + "\r\n" + jsonbPath + "\r\n" + listPath + "\r\n" + formPath;
        return str;
    }

    /**
     * 生成文件夹
     *
     * @param floderPath 文件夹路径
     */
    private static void generateFloder(String floderPath) {
        File floder = new File(floderPath);
        if (!floder.exists()) {
            floder.mkdirs();
        }
    }
}
