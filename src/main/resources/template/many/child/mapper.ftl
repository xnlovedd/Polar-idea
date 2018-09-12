<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${code.packageName}.${code.moduleName}.dao.${code.daoName}">
    <#assign has=false/>
    <#list columns as mData><#if  mData.type==10||mData.type==12><#assign has=true/>
    </#if></#list>
    <sql id="columns">
	<#assign sql>
		a.${code.idField} AS "${code.idField}",
		<#if code.deleteMode!=1>a.${code.effectivenessField} AS "${code.effectivenessField}",</#if>
		<#list columns as mData>
			<#if  mData.type!=10&&mData.type!=12>
        a.${mData.name} AS "${mData.javaName}",
			</#if>
		</#list>
        <#if has>
		b.visitPath AS "attachment.visitPath",
        b.id AS "attachment.id",
		b.attachmentId AS "attachment.attachmentId",
		b.typeStr AS "attachment.type",
		b.pid AS "attachment.type",
        </#if>
	</#assign>
	${sql?substring(0, sql?last_index_of(","))}
    </sql>
    <!-- 表名,可能查询时会和一些其他的表关联 -->
    <sql id="tables">
	${code.tableName} a <#if has><#assign sql><#list columns as mData><#if  mData.type==10||mData.type==12>b.typeStr='${code.tableName}_${mData.javaName}' OR </#if></#list></#assign> left join t_polar_attachment b on(a.${code.idField}=b.attachmentId AND (${sql?substring(0, sql?last_index_of("OR"))}))</#if>
    </sql>
    <!-- 表名 -->
    <sql id="table">
	${code.tableName}
    </sql>
    <!-- 查询多条数据时的条件 -->
    <sql id="searchMultiWheres">
        <where>
            1=1
				<#if code.deleteMode!=1>
			and  a.${code.effectivenessField}=<#if code.effectivenessType ==0> '${code.effectivenessValue}'<#else>${code.effectivenessValue}</#if>
				</#if>
            <if test="${code.idField} != null<#if code.idType ==0> and ${code.idField} != ''</#if>">
                AND a.${code.idField}=${"#"}{${code.idField}}
            </if>
		<#list columns as mData>
			<#if  mData.type!=10&&mData.type!=12&&mData.type!=13&&mData.type!=14>
			<if test="${mData.javaName} != null<#if mData.type ==0 ||mData.type ==1 ||mData.type ==5||mData.type ==8||mData.type ==10> and ${mData.javaName} != ''</#if>">
				<#if mData.matchStyle==0>
                    AND a.${mData.name}=${"#"}{${mData.javaName}}
				</#if>
				<#if mData.matchStyle==1>
					AND a.${mData.name} like
					<choose>
                        <when test="'${"$"}{polar_dataBaseType}' == 'sqlServer'">
                            '%'+${"#"}{${mData.javaName}}+'%'
                        </when>
                        <otherwise>
                            concat('%',${"#"}{${mData.javaName}},'%')
                        </otherwise>
                    </choose>
				</#if>
				<#if mData.matchStyle==2>
                    AND a.${mData.name}&lt;${"#"}{${mData.javaName}}
				</#if>
				<#if mData.matchStyle==3>
                    AND a.${mData.name}&gt;${"#"}{${mData.javaName}}
				</#if>
				<#if mData.matchStyle==4>
                    AND a.${mData.name}&lt;=${"#"}{${mData.javaName}}
				</#if>
				<#if mData.matchStyle==5>
                    AND a.${mData.name}&gt;=${"#"}{${mData.javaName}}
				</#if>
            </if>
			</#if>
		</#list>
        </where>
    </sql>
    <!-- 查询单条数据时的条件 -->
    <sql id="searchOneWheres">
        <where>
            <if test="${code.idField} != null<#if code.idType ==0> and ${code.idField} != ''</#if>">
                AND a.${code.idField}=${"#"}{${code.idField}}
            </if>
			<#if code.deleteMode!=1>
			<if test="${code.effectivenessField} != null<#if code.effectivenessType ==0> and ${code.effectivenessType} != ''</#if>">
                AND a.${code.effectivenessField}=${"#"}{${code.effectivenessField}}
            </if>
			</#if>
		<#list columns as mData>
			<#if  mData.type!=10&&mData.type!=12&&mData.type!=13&&mData.type!=14>
			<if test="${mData.javaName} != null<#if mData.type ==0 ||mData.type ==1 ||mData.type ==5||mData.type ==8||mData.type ==10> and ${mData.javaName} != ''</#if>">
                AND a.${mData.name}=${"#"}{${mData.javaName}}
            </if>
			</#if>
		</#list>
        </where>
    </sql>
    <!-- 排序条件 -->
    <sql id="orderCondition">
        <choose>
            <when test="sort !=null and sort !=''">
                order by
                <choose>
				<#list columns as mData>
					<#if  mData.type!=10&&mData.type!=12>
				<when test="sort=='${mData.javaName}'">a.${mData.name} ${"$"}{order}</when>
					</#if>
				</#list>
                    <!--默认排序，条件都不满足时，使用此条件，其兼容sqlserver的分页排序 -->
                    <otherwise>(SELECT 0)</otherwise>
                </choose>
            </when>
            <otherwise>
                <choose>
                    <when test="'${"$"}{polar_dataBaseType}' == 'sqlServer'">
                        order by (SELECT 0)
                    </when>
                </choose>
            </otherwise>
        </choose>
    </sql>
	<#if code.deleteMode!=2>
	<!-- 删除条件(物理删除的删除条件) -->
	<sql id="deletePhysicalWheres">
        WHERE 1!=1
        <trim prefix="OR" prefixOverrides="AND">
			<#if code.deleteMode!=1>
				<if test="${code.effectivenessField} != null<#if code.effectivenessType ==0> and ${code.effectivenessField} != ''</#if>">
                    AND ${code.effectivenessField}=${"#"}{${code.effectivenessField}}
                </if>
			</#if>
            <if test="${code.idField} != null<#if code.idType ==0> and ${code.idField} != ''</#if>">
                AND ${code.idField}=${"#"}{${code.idField}}
            </if>
			<#list columns as mData>
				<#if  mData.type!=10&&mData.type!=12>
				<if test="${mData.javaName} != null<#if mData.type ==0 ||mData.type ==1 ||mData.type ==5||mData.type ==8||mData.type ==10> and ${mData.javaName} != ''</#if>">
                    AND ${mData.name}=${"#"}{${mData.javaName}}
                </if>
				</#if>
			</#list>
        </trim>
    </sql>
	</#if>
	<#if code.deleteMode!=1>
	<!-- 逻辑删除条件(逻辑删除的删除条件，比物理删除缺少数据有效性字段) -->
	<sql id="deleteLogicWheres">
        WHERE 1!=1
        <trim prefix="OR" prefixOverrides="AND">
            <if test="${code.idField} != null<#if code.idType ==0> and ${code.idField} != ''</#if>">
                AND ${code.idField}=${"#"}{${code.idField}}
            </if>
			<#list columns as mData>
				<#if  mData.type!=10&&mData.type!=12>
				<if test="${mData.javaName} != null<#if mData.type ==0 ||mData.type ==1 ||mData.type ==5||mData.type ==8||mData.type ==10> and ${mData.javaName} != ''</#if>">
                    AND ${mData.name}=${"#"}{${mData.javaName}}
                </if>
				</#if>
			</#list>
        </trim>
    </sql>
	<!-- 逻辑删除时，执行的字段，将有效性字段设置为无效 -->
	<sql id="deleteLogicSql">
        set ${code.effectivenessField}=<#if code.effectivenessType ==0>'</#if>${code.unEffectivenessValue}<#if code.effectivenessType ==0>'</#if>
    </sql>
	</#if>
    <insert id="insert" parameterType="java.util.Map"  useGeneratedKeys="true" keyProperty="${code.idField}">
        INSERT INTO
        <include refid="table" />
        (
		<#assign sql>
			<#if code.idType!=0>
				${code.idField},
			</#if>
			<#list columns as mData>
            <#if mData.type!=10&&mData.type!=12>
                ${mData.name},
            </#if>
			</#list>
			<#if code.deleteMode!=1>
				${code.effectivenessField},
			</#if>
		</#assign>
	${sql?substring(0, sql?last_index_of(","))}
        ) VALUES (
		<#assign sql>
			<#if code.idType!=0>
				${"#"}{${code.idField}},
			</#if>
			<#list columns as mData>
                <#if mData.type!=10&&mData.type!=12>
				${"#"}{${mData.javaName}},
                </#if>
			</#list>
			<#if code.deleteMode!=1>
				<#if code.effectivenessType=0>'${code.effectivenessValue}',<#else>${code.effectivenessValue},</#if>
			</#if>
		</#assign>
	${sql?substring(0, sql?last_index_of(","))}
        )
    </insert>
    <!-- 查询一条数据(依据数据编号) -->
    <select id="selectOneById" <#if code.moduleType==0 ||code.moduleType==2>resultType="java.util.Map"<#else>resultType="${code.entityAlias}"</#if>
            parameterType="string">
        SELECT
        <include refid="columns" />
        FROM
        <include refid="tables" />
        where a.${code.idField}=${"#"}{id}
    </select>
    <!-- 查询一条数据（依据查询条件） -->
    <select id="selectOneByCondition" <#if code.moduleType==0 ||code.moduleType==2>resultType="java.util.Map"<#else>resultType="${code.entityAlias}"</#if>
            parameterType="string">
        SELECT
        <include refid="columns" />
        FROM
        <include refid="tables" />
        <include refid="searchOneWheres" />
    </select>
    <!-- 查询集合 -->
    <select id="selectList" <#if code.moduleType==0 ||code.moduleType==2>resultType="java.util.Map"<#else>resultType="${code.entityAlias}"</#if>
            parameterType="java.util.Map">
        SELECT
        <include refid="columns" />
        FROM
        <include refid="tables" />
        <include refid="searchMultiWheres" />
        <include refid="orderCondition" />
    </select>
    <!-- 查询导出数据集合 -->
    <select id="selectExportList" resultType="java.util.Map"
            parameterType="java.util.Map">
        SELECT
        <include refid="columns" />
        FROM
        <include refid="tables" />
        <include refid="searchMultiWheres" />
        <include refid="orderCondition" />
    </select>
    <!-- 查询带有分页的列表 -->
    <select id="selectPageList" <#if code.moduleType==0 ||code.moduleType==2>resultType="java.util.Map"<#else>resultType="${code.entityAlias}"</#if>
            parameterType="java.util.Map">
        <choose>
            <when test="'${"$"}{polar_dataBaseType}' == 'oracle'">
                SELECT * FROM (
                select rownum rowsize,innertable.* from
                (
                SELECT <include refid="columns" />
                FROM <include refid="tables" />
                <include refid="searchMultiWheres" />
                <include refid="orderCondition" />
                ) innertable
                )
                WHERE rowsize > ${"#"}{pageStartNumber} and rowsize &lt;= ${"#"}{pageOffsetNumber}
            </when>
            <when test="'${"$"}{polar_dataBaseType}' == 'sqlServer'">
                SELECT TOP ${"$"}{rows} A.*
                FROM
                (
                SELECT
                ROW_NUMBER() OVER (<include refid="orderCondition" />) AS RowNumber,
                <include refid="columns" />
                FROM <include refid="tables" />
                <include refid="searchMultiWheres" />
                )   as A
                WHERE RowNumber > ${"#"}{pageStartNumber}
            </when>
            <otherwise>
                SELECT
                <include refid="columns" />
                FROM
                <include refid="tables" />
                <include refid="searchMultiWheres" />
                <include refid="orderCondition" />
                limit ${"#"}{pageStartNumber},${"#"}{pageOffsetNumber}
            </otherwise>
        </choose>


    </select>
    <!-- 依据条件查询符合条件的数量 -->
    <select id="selectCount" resultType="long" parameterType="java.util.Map">
        SELECT count(a.${code.idField})
        FROM
        <include refid="tables" />
        <include refid="searchMultiWheres" />
    </select>
    <!-- 依据编号更新数据，所有字段都更新。 -->
    <update id="updateAll" parameterType="java.util.Map">
        update
        <include refid="table" />
        set
		<#assign sql>
			<#list columns as mData>
                <#if mData.type!=10&&mData.type!=12>
				${mData.name}=${"#"}{${mData.javaName}},
                </#if>
			</#list>
		</#assign>
	${sql?substring(0, sql?last_index_of(","))}
        where ${code.idField}=${"#"}{${code.idField}}
    </update>
    <!-- 依据编号更新数据，更新存在的字段,有效性字段也可更新。 -->
    <update id="updateField" parameterType="java.util.Map">
        update
        <include refid="table" />
        <trim prefix="set" prefixOverrides=",">
			<#if code.deleteMode!=1>
				<if test="_parameter.containsKey('${code.effectivenessField}')">
                    ,${code.effectivenessField}=${"#"}{${code.effectivenessField}}
                </if>
			</#if>
			<#list columns as mData>
                <#if mData.type!=10&&mData.type!=12>
				<if test="_parameter.containsKey('${mData.javaName}')">
                    ,${mData.name}=${"#"}{${mData.javaName}}
                </if>
                </#if>
			</#list>
        </trim>
        where ${code.idField}=${"#"}{${code.idField}}
    </update>
	<#if code.deleteMode !=2>
	<!-- 依据编号物理删除 -->
	<delete id="deleteByIdPhysical" parameterType="string">
        delete from
        <include refid="table" />
        where ${code.idField}=${"#"}{id}
    </delete>
	</#if>
	<#if code.deleteMode !=1>
	<!-- 依据编号逻辑删除 -->
	<update id="deleteByIdLogic" parameterType="string">
        update
        <include refid="table" />
        <include refid="deleteLogicSql" />
        where ${code.idField}=${"#"}{id}
    </update>
	</#if>
	<#if code.deleteMode !=2>
	<!-- 依据条件物理删除 -->
	<delete id="deleteByConditionPhysical" parameterType="string">
        delete from
        <include refid="table" />
        <include refid="deletePhysicalWheres" />
    </delete>
	</#if>
	<#if code.deleteMode !=1>
	<!-- 依据条件逻辑删除 -->
	<update id="deleteByConditionLogic" parameterType="string">
        update
        <include refid="table" />
        <include refid="deleteLogicSql" />
        <include refid="deleteLogicWheres" />
    </update>
	</#if>
</mapper>