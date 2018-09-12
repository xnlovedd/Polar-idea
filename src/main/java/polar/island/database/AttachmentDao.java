package polar.island.database;

import org.apache.ibatis.annotations.Param;
import polar.island.core.entity.AttachmentEntity;

import java.util.List;

/**
 * 附件的持久化层。
 *
 * @author PolarLoves
 */
@DAO(value = "attachmentDao")
public interface AttachmentDao {
    /**
     * 增加一条附件信息
     * @param entity 附件信息
     */
    public void insert(AttachmentEntity entity);

    /**
     * 删除附件信息
     * @param type 附件类型，格式：表名_字段名
     * @param attachmentId 外键编号
     * @return 删除数量
     */
    public Long deleteAttachment(@Param(value = "type") String type, @Param(value = "attachmentId") String attachmentId);

    /**
     * 查询附件
     * @param type 附件类型，格式：表名_字段名
     * @param attachmentId 外键编号
     * @return 查询到的条目
     */
    public List<String> selectAttachment(@Param(value = "type") String type, @Param(value = "attachmentId") String attachmentId);
    /**
     * 删除附件信息
     * @param type 附件类型，格式：表名_字段名
     * @param pid 其他外键编号
     * @return 删除数量
     */
    public Long deleteAttachmentByPid(@Param(value = "type") String type, @Param(value = "pid") String pid);
}
