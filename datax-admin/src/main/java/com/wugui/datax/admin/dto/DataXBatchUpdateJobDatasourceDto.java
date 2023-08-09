package com.wugui.datax.admin.dto;

import lombok.Data;

import java.util.List;

/**
 * 批量更新任务数据移dto
 *
 * @author fancyxie
 * @ClassName DataXBatchUpdateJobDatasourceDto
 * @Version 2.1.2
 * @since 2023/08/06 23:26
 */
@Data
public class DataXBatchUpdateJobDatasourceDto {
    private Integer datasourceId; // 数据源id

    private Integer batchUpdateJobDatasourceType;  // 0-reader 1-writer

    private Integer batchUpdateJobOptionType; // 0-项目 1-任务

    private List<Integer> batchUpdateJobList;
}
