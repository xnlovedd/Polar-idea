package polar.island.inlay.code.service;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import polar.island.core.config.Constants;
import polar.island.core.exception.DataNotExistException;
import polar.island.core.exception.FrameWorkException;
import polar.island.core.service.BasicServiceImpl;
import polar.island.core.util.CommonUtil;
import polar.island.core.util.EntityUtil;
import polar.island.core.util.GsonUtil;
import polar.island.core.util.PropertieUtil;
import polar.island.database.SqlDao;
import polar.island.inlay.code.dao.CodeDao;
import polar.island.inlay.code.entity.CodeColumn;
import polar.island.inlay.code.entity.CodeDefaults;
import polar.island.inlay.code.entity.CodeEntity;
import polar.island.inlay.code.entity.JdbcType;
import polar.island.inlay.menu.dao.MenuDao;
import polar.island.inlay.permission.dao.PermissionDao;
import polar.island.inlay.role.dao.RoleDao;

import javax.annotation.Resource;
import java.util.*;

@Transactional(readOnly = true)
@Service(value = "codeService")
public class CodeServiceImpl extends BasicServiceImpl<CodeEntity, CodeEntity, CodeDao> implements CodeService {
    @Resource(name = "codeDao")
    private CodeDao codeDao;
    @Resource(name = "sqlDao")
    private SqlDao sqlDao;
    @Resource(name = "permissionDao")
    private PermissionDao permissionDao;
    @Resource(name = "roleDao")
    private RoleDao roleDao;
    @Resource(name = "menuDao")
    private MenuDao menuDao;

    @Override
    public CodeDao getDao() {
        return codeDao;
    }

    @Transactional(readOnly = false)
    @Override
    public Long deleteMulitByIdPhysical(String[] ids) {
        Long result = 0L;
        for (String id : ids) {
            result = result + codeDao.deleteByIdPhysical(id);
            codeDao.deleteColumns(CommonUtil.str2Long(id));
        }
        return result;
    }

    @Transactional(readOnly = false)
    @Override
    public Long deleteByIdPhysical(String id) {
        codeDao.deleteColumns(CommonUtil.str2Long(id));
        return super.deleteByIdPhysical(id);
    }

    public List<Map<String, Object>> allTableNames() {
        //String sql = "SELECT t.table_name AS name,t.TABLE_COMMENT AS comments  FROM information_schema.`TABLES` t  WHERE t.TABLE_SCHEMA = (select database()) and t.table_name not in(select tableName from t_polar_tables) and t.table_name not like 't_polar%' ORDER BY t.TABLE_NAME";
        return codeDao.allTableNames();
    }

    @Transactional(readOnly = false)
    @Override
    public void importTable(String tableName, String commont, String moduleName) {
        List<Map<String, Object>> pks = codeDao.selectPkFromTable(tableName);
        String idField = CodeDefaults.ID_FIELD;
        Integer idType = CodeDefaults.ID_TYPE;
        Integer deleteMode = CodeDefaults.DELETE_MODE;
        String effField = CodeDefaults.EFF_FIELD;
        Integer effType = CodeDefaults.EFF_TYPE;
        if (pks != null && !pks.isEmpty()) {
            idField = pks.get(0).get("name").toString();
            String mType = pks.get(0).get("type").toString();
            if (mType.startsWith("int") || mType.startsWith("bigint")) {
                idType = 0;
            } else {
                idType = 1;
            }
        }
        boolean has = false;
        List<JdbcType> types = codeDao.selectColumnsFromTable(tableName);

        if (types != null && !types.isEmpty()) {

            for (JdbcType type : types) {
                if (type.getName().equalsIgnoreCase(idField)) {
                    // 主键不作为列属性。
                    idField = type.getName();
                    continue;
                }
                if (type.getName().equalsIgnoreCase(effField)) {
                    effField = type.getName();
                    has = true;
                    deleteMode = 0;
                    if (type.getType().startsWith("int") || type.getType().startsWith("bigint")) {
                        effType = 0;
                    } else {
                        effType = 1;
                    }
                    continue;
                }
            }
        }
        if (!has) {
            deleteMode = 1;
        }
        CodeEntity entity = new CodeEntity();
        Date nowDate = new Date();
        String moduleNameBig = moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1);
        entity.setListModule(0);// 默认layui模板
        entity.setTableType(0);
        entity.setAuthor(CodeDefaults.AUTHOR);
        entity.setTableName(tableName);
        entity.setTableRemark(commont);
        entity.setDeleteMode(deleteMode);
        entity.setIdField(idField);
        entity.setIdType(idType);
        entity.setEffectivenessField(effField);
        entity.setEffectivenessValue(CodeDefaults.EFF_VALUE);
        entity.setUnEffectivenessValue(CodeDefaults.UNEFF_VALUE);
        entity.setPackageName(CodeDefaults.PACKAGE_NAME);
        entity.setModuleName(moduleName);
        entity.setModuleRemark(commont);
        entity.setAuthor(CodeDefaults.AUTHOR);
        entity.setControllerWebPath("/" + moduleName + "/web");
        entity.setControllerJsonPath("/" + moduleName + "/json");
        entity.setControllerWebName(moduleNameBig + "WebController");
        entity.setControllerWebTag(moduleName + "WebController");
        entity.setControllerJsonTag(moduleName + "JsonController");
        entity.setControllerJsonName(moduleNameBig + "JsonController");
        entity.setServiceImplName(moduleNameBig + "ServiceImpl");
        entity.setServiceName(moduleNameBig + "Service");
        entity.setServiceTag(moduleName + "Service");
        entity.setDaoName(moduleNameBig + "Dao");
        entity.setDaoTag(moduleName + "Dao");
        entity.setMapperFileName(moduleName + "Mapper");
        entity.setMapperFloderName(moduleName);
        entity.setJspListName(moduleName + "List");
        entity.setJspEditName(moduleName + "Form");
        entity.setCreateDate(nowDate);
        entity.setUpdateDate(nowDate);
        entity.setValidateType(CodeDefaults.VALIDATE_TYPE);
        entity.setEffectivenessType(effType);
        entity.setModuleType(CodeDefaults.MODULE_TYPE);
        entity.setEntityAlias(moduleNameBig + "Entity");
        entity.setEntityName(moduleNameBig + "Entity");
        Map<String, Object> values = EntityUtil.beanToMap(entity);
        codeDao.insert(values);
        Long tableId = CommonUtil.str2Long(values.get("id").toString());
        genColumns(tableId, entity);

    }

    @Transactional(readOnly = false)
    public void genColumns(Long tableId, CodeEntity entity) {
        codeDao.deleteColumns(tableId);
        List<JdbcType> types = codeDao.selectColumnsFromTable(entity.getTableName());
        if (types != null && !types.isEmpty()) {
            int index = 0;
            for (JdbcType type : types) {
                if (type.getName().equalsIgnoreCase(entity.getIdField())) {
                    // 主键不作为列属性。
                    continue;
                }
                if (entity.getDeleteMode() != 1 && type.getName().equalsIgnoreCase(entity.getEffectivenessField())) {
                    continue;
                }
                if (type.getCommonts() == null || type.getCommonts().equals("")) {
                    type.setCommonts("auto generate code");
                }
                // 开始解析列
                CodeColumn column = new CodeColumn();
                column.setName(type.getName());
                column.setOrderNum(index);
                Integer fieldType = 0;
                if (type.getType().startsWith("int") || type.getType().startsWith("bigint")) {
                    int mLength = -1;
                    mLength = CommonUtil.str2Int(
                            type.getType().substring(type.getType().indexOf('(') + 1, type.getType().indexOf(')')));

                    if (mLength > 10) {
                        fieldType = 9;
                    } else {
                        fieldType = 2;
                    }
                } else if (type.getType().startsWith("float") || type.getType().startsWith("double")
                        || type.getType().startsWith("decimal")) {
                    fieldType = 3;
                } else if (type.getType().startsWith("varchar")) {
                    int mLength = -1;
                    mLength = CommonUtil.str2Int(
                            type.getType().substring(type.getType().indexOf('(') + 1, type.getType().indexOf(')')));
                    if (mLength > 1000) {
                        fieldType = 1;
                    } else {
                        fieldType = 0;
                    }
                } else if (type.getType().startsWith("date")) {
                    fieldType = 4;
                } else {
                    fieldType = 0;
                }
                column.setType(fieldType);
                column.setCommont(type.getCommonts());
                column.setJavaName(type.getName());
                String com = type.getCommonts();
                if (com != null && !com.equals("")) {
                    if (com.contains("(")) {
                        com = com.substring(0, com.indexOf('('));
                    } else if (com.contains(",")) {
                        com = com.split(",")[0];
                    } else if (com.contains("，")) {
                        com = com.split("，")[0];
                    }
                }
                column.setRemark(com);
                int value = 0;
                if (index <= 5) {
                    value = 1;
                }
                column.setSearch(value);
                column.setListShown(value);
                column.setInnerEdit(0);
                column.setRequired(type.getRequired());
                column.setOrderBy(value);
                column.setListReturn(1);
                column.setPhone(0);
                column.setEmail(0);
                column.setIdentity(0);
                column.setMatchStyle(0);
                column.setTableId(tableId);
                codeDao.insertColumns(column);
                index++;
            }
        }
    }

    @Transactional(readOnly = false)
    @Override
    public void insertColumns(List<CodeColumn> codeColumn, Long tableId) {
        codeDao.deleteColumns(tableId);
        int index = 0;
        for (CodeColumn c : codeColumn) {
            c.setTableId(tableId);
            c.setOrderNum(index);
            codeDao.insertColumns(c);
            index++;
        }
    }

    @Override
    public List<CodeColumn> selectColumns(Long tableId) {
        return codeDao.selectColumns(tableId);
    }

    @Transactional(readOnly = false)
    @Override
    public Object insert(Map<String, Object> condition) {
        codeDao.insert(condition);
        return condition.get("id");
    }

    @Transactional(readOnly = false)
    @Override
    public void genSettings(CodeEntity entity) {
        String name = entity.getModuleName();
        String cName = entity.getTableRemark();
        Long maxRoleOrder = roleDao.maxOrderNum();
        Long maxPermissionOrder = permissionDao.maxOrderNum();
        Long maxMenuOrder = menuDao.maxOrderNum();
        if (maxRoleOrder == null) {
            maxRoleOrder = 0l;
        } else {
            maxRoleOrder = maxRoleOrder + 1;
        }
        if (maxPermissionOrder == null) {
            maxPermissionOrder = 0l;
        } else {
            maxPermissionOrder = maxPermissionOrder + 1;
        }
        if (maxMenuOrder == null) {
            maxMenuOrder = 0l;
        } else {
            maxMenuOrder = maxMenuOrder + 1;
        }
        // 生成权限...
        String rootId = insertPermission(null, name + ":empty", cName, cName + "的空白权限，用来分组。", maxPermissionOrder);
        String rootId1 = insertPermission(rootId + "", name + ":add", "添加" + cName, cName + "的增加权限。", 1l);
        String rootId2 = insertPermission(rootId + "", name + ":delete", "删除" + cName, cName + "的删除权限。", 2l);
        String rootId3 = insertPermission(rootId + "", name + ":edit", "修改" + cName, cName + "的修改权限。", 3l);
        String rootId4 = insertPermission(rootId + "", name + ":view:detail", "查看" + cName + "详情", cName + "的查看详情权限",
                4l);
        String rootId5 = insertPermission(rootId + "", name + ":view:list", "查看" + cName + "列表", cName + "的查看列表权限", 5l);
        String rootId6 = insertPermission(rootId + "", name + ":excell:import", "导入" + cName, "导入" + cName + "的权限", 6l);
        String rootId7 = insertPermission(rootId + "", name + ":excell:export", "导出" + cName, "导出" + cName + "的权限", 7l);
        // 生成角色...
        /*
         * String roleId = insertRole(Permissions.SUPER_ADMIN_ID, name+":empty",
         * cName + "管理",cName + "管理,空白角色，没有任何权限", maxRoleOrder); String roleId1
         * = insertRole(rootId + "", name + ":add", "添加" + cName, cName +
         * "的增加角色。", 1l); String roleId2 = insertRole(rootId + "", name +
         * ":delete", "删除" + cName, cName + "的删除角色。", 2l); String roleId3 =
         * insertRole(rootId + "", name + ":update", "修改" + cName, cName +
         * "的修改角色。", 3l); String roleId4 = insertRole(rootId + "", name +
         * ":view:detail", "查看" + cName , cName + "的查看详情角色", 4l); String roleId5
         * = insertRole(rootId + "", name + ":view:list", "查看" + cName , cName +
         * "的查看列表角色", 5l);
         */
        // 给角色添加权限
        /*
         * insertRolePermission(rootId, roleId); insertRolePermission(rootId1,
         * roleId1); insertRolePermission(rootId2, roleId2);
         * insertRolePermission(rootId3, roleId3); insertRolePermission(rootId4,
         * roleId4); insertRolePermission(rootId5, roleId5);
         */
        // 给超级管理员添加权限
        insertRolePermission(rootId, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId1, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId2, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId3, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId4, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId5, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId6, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        insertRolePermission(rootId7, PropertieUtil.getSetting("SUPER_ADMIN_ID"));
        // 生成菜单...
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("name", entity.getTableRemark());
        condition.put("icon", "user");
        condition.put("path", entity.getControllerWebPath());
        condition.put("orderNum", maxMenuOrder);

    }

    @Override
    public List<Map<String, Object>> allChildrens(String parentTableId) {
        List<Map<String, Object>> children = new ArrayList<>();
        //依据parentTableId查询所有的子表
        Map<String, Object> args = new HashMap<>();
        args.put("parentTableId", parentTableId);
        List<CodeEntity> childrenTables = codeDao.selectList(args);
        for (CodeEntity child : childrenTables) {
            Map<String, Object> childData = new HashMap<String, Object>();
            childData.put("code", child);
            List<CodeColumn> childColumns = null;
            childColumns = codeDao.selectColumns(child.getId());
            if (childColumns == null || childColumns.isEmpty()) {
                throw new DataNotExistException(child.getTableRemark()+"列未配置， 请先配置列属性", null);
            }
            List<Map<String, Object>> columnData=new ArrayList<Map<String, Object>>();
            for(CodeColumn column:childColumns){
                Map<String, Object> bean= EntityUtil.beanToMap(column);
                String groupName=StringEscapeUtils.unescapeHtml4(CommonUtil.valueOf(bean.get("groupName")));
                if(StringUtils.isEmpty(groupName)){
                    Map<String, Object> groupData= new HashMap<>();
                    bean.put("group",groupData);
                    columnData.add(bean);
                    continue;
                }
                String[] groups=groupName.split(",");
                String group="";
                if(groups!=null&&groups.length>0){
                    int index=0;
                    for(String temp:groups){
                        String str=temp.replace(":","\":\"");
                        str="\""+str+"\"";
                        if(index==0){
                            group=group+str;
                        }else {
                            group=group+","+str;
                        }
                        index++;
                    }
                }
                group="{"+group+"}";
                Map<String, Object> groupData= GsonUtil.jsonToObject(group,HashMap.class);
                bean.put("group",groupData);
                columnData.add(bean);
            }

            childData.put("columns", columnData);
            children.add(childData);
        }
        return children;
    }

    private void insertRolePermission(String permissionId, String roleId) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("permissionId", permissionId);
        condition.put("roleId", roleId);
        permissionDao.insertRolePermission(condition);
    }

    private String insertPermission(String parentId, String name, String text, String info, Long orderNum) {
        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("parentId", parentId);
        condition.put("name", name);
        condition.put("text", text);
        condition.put("info", info);
        condition.put("orderNum", orderNum);
        try {
            permissionDao.insert(condition);
        } catch (org.springframework.dao.DuplicateKeyException e) {
            throw new FrameWorkException(Constants.CODE_SERVER_COMMON, "标识为\"" + condition.get("name") + "\"的权限已存在",
                    null, false);
        }
        return condition.get("id").toString();
    }

    /*
     * private String insertRole(String parentId, String name, String text,
     * String info, Long orderNum) { Map<String, Object> condition = new
     * HashMap<String, Object>(); condition.put("parentId", parentId);
     * condition.put("name", name); condition.put("text", text);
     * condition.put("info", info); condition.put("orderNum", orderNum); try {
     * roleDao.insert(condition); } catch
     * (org.springframework.dao.DuplicateKeyException e) { throw new
     * FrameWorkException(Constants.CODE_SERVER_COMMON, "标识为\"" +
     * condition.get("name") + "\"的角色已存在", null, false); } return
     * condition.get("id").toString(); }
     */
}
