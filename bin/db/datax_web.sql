/*
 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : datax_web
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

--
-- Table structure for table `job_group`
--
DROP TABLE IF EXISTS `job_group`;
CREATE TABLE `job_group` (
                             `id` int NOT NULL AUTO_INCREMENT,
                             `app_name` varchar(64)  NOT NULL COMMENT '执行器AppName',
                             `title` varchar(12)  NOT NULL COMMENT '执行器名称',
                             `order` int NOT NULL DEFAULT '0' COMMENT '排序',
                             `address_type` tinyint NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
                             `address_list` varchar(512)  DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `job_group`
--
LOCK TABLES `job_group` WRITE;
INSERT INTO `job_group` VALUES (1,'datax-executor','datax执行器',1,0,'10.191.40.245:9999');
UNLOCK TABLES;

--
-- Table structure for table `job_info`
--
DROP TABLE IF EXISTS `job_info`;
CREATE TABLE `job_info` (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `job_group` int NOT NULL COMMENT '执行器主键ID',
                            `job_cron` varchar(128)  NOT NULL COMMENT '任务执行CRON',
                            `job_desc` varchar(255)  NOT NULL,
                            `project_id` int DEFAULT NULL COMMENT '所属项目id',
                            `add_time` datetime DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `user_id` int NOT NULL COMMENT '修改用户',
                            `alarm_email` varchar(255)  DEFAULT NULL COMMENT '报警邮件',
                            `executor_route_strategy` varchar(50)  DEFAULT NULL COMMENT '执行器路由策略',
                            `executor_handler` varchar(255)  DEFAULT NULL COMMENT '执行器任务handler',
                            `executor_param` varchar(512)  DEFAULT NULL COMMENT '执行器任务参数',
                            `executor_block_strategy` varchar(50)  DEFAULT NULL COMMENT '阻塞处理策略',
                            `executor_timeout` int NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位分钟',
                            `executor_fail_retry_count` int NOT NULL DEFAULT '0' COMMENT '失败重试次数',
                            `glue_type` varchar(50)  NOT NULL COMMENT 'GLUE类型',
                            `glue_source` mediumtext  COMMENT 'GLUE源代码',
                            `glue_remark` varchar(128)  DEFAULT NULL COMMENT 'GLUE备注',
                            `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
                            `child_jobid` varchar(255)  DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
                            `trigger_status` tinyint NOT NULL DEFAULT '0' COMMENT '调度状态：0-停止，1-运行',
                            `trigger_last_time` bigint NOT NULL DEFAULT '0' COMMENT '上次调度时间',
                            `trigger_next_time` bigint NOT NULL DEFAULT '0' COMMENT '下次调度时间',
                            `job_json` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'datax运行脚本',
                            `replace_param` varchar(100)  DEFAULT NULL COMMENT '动态参数',
                            `jvm_param` varchar(200)  DEFAULT NULL COMMENT 'jvm参数',
                            `inc_start_time` datetime DEFAULT NULL COMMENT '增量初始时间',
                            `partition_info` varchar(100)  DEFAULT NULL COMMENT '分区信息',
                            `last_handle_code` int DEFAULT '0' COMMENT '最近一次执行状态',
                            `replace_param_type` varchar(255)  DEFAULT NULL COMMENT '增量时间格式',
                            `reader_table` varchar(255)  DEFAULT NULL COMMENT 'reader表名称',
                            `primary_key` varchar(50)  DEFAULT NULL COMMENT '增量表主键',
                            `inc_start_id` varchar(20)  DEFAULT NULL COMMENT '增量初始id',
                            `increment_type` tinyint DEFAULT '0' COMMENT '增量类型',
                            `datasource_id` bigint DEFAULT NULL COMMENT '数据源id',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_jdbc_datasource`
--

DROP TABLE IF EXISTS `job_jdbc_datasource`;
CREATE TABLE `job_jdbc_datasource` (
                                       `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
                                       `datasource_name` varchar(200)  NOT NULL COMMENT '数据源名称',
                                       `datasource` varchar(45)  NOT NULL COMMENT '数据源',
                                       `datasource_group` varchar(200)  DEFAULT 'Default' COMMENT '数据源分组',
                                       `database_name` varchar(45)  DEFAULT NULL COMMENT '数据库名',
                                       `jdbc_username` varchar(100)  DEFAULT NULL COMMENT '用户名',
                                       `jdbc_password` varchar(200)  DEFAULT NULL COMMENT '密码',
                                       `jdbc_url` varchar(500)  NOT NULL COMMENT 'jdbc url',
                                       `jdbc_driver_class` varchar(200)  DEFAULT NULL COMMENT 'jdbc驱动类',
                                       `zk_adress` varchar(200)  DEFAULT NULL,
                                       `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0删除 1启用 2禁用',
                                       `create_by` varchar(20)  DEFAULT NULL COMMENT '创建人',
                                       `create_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `update_by` varchar(20)  DEFAULT NULL COMMENT '更新人',
                                       `update_date` datetime DEFAULT NULL COMMENT '更新时间',
                                       `comments` varchar(1000)  DEFAULT NULL COMMENT '备注',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='jdbc数据源配置';

--
-- Table structure for table `job_lock`
--

DROP TABLE IF EXISTS `job_lock`;
CREATE TABLE `job_lock` (
                            `lock_name` varchar(50)  NOT NULL COMMENT '锁名称',
                            PRIMARY KEY (`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `job_lock`
--

LOCK TABLES `job_lock` WRITE;
INSERT INTO `job_lock` VALUES ('schedule_lock');
UNLOCK TABLES;

--
-- Table structure for table `job_log`
--

DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `job_group` int NOT NULL COMMENT '执行器主键ID',
                           `job_id` int NOT NULL COMMENT '任务，主键ID',
                           `job_desc` varchar(255)  DEFAULT NULL,
                           `executor_address` varchar(255)  DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
                           `executor_handler` varchar(255)  DEFAULT NULL COMMENT '执行器任务handler',
                           `executor_param` varchar(512)  DEFAULT NULL COMMENT '执行器任务参数',
                           `executor_sharding_param` varchar(20)  DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
                           `executor_fail_retry_count` int DEFAULT '0' COMMENT '失败重试次数',
                           `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
                           `trigger_code` int NOT NULL COMMENT '调度-结果',
                           `trigger_msg` text  COMMENT '调度-日志',
                           `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
                           `handle_code` int NOT NULL COMMENT '执行-状态',
                           `handle_msg` text  COMMENT '执行-日志',
                           `alarm_status` tinyint NOT NULL DEFAULT '0' COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
                           `process_id` varchar(20)  DEFAULT NULL COMMENT 'datax进程Id',
                           `max_id` bigint DEFAULT NULL COMMENT '增量表max id',
                           PRIMARY KEY (`id`) USING BTREE,
                           KEY `I_trigger_time` (`trigger_time`) USING BTREE,
                           KEY `I_handle_code` (`handle_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_log_report`
--

DROP TABLE IF EXISTS `job_log_report`;
CREATE TABLE `job_log_report` (
                                  `id` int NOT NULL AUTO_INCREMENT,
                                  `trigger_day` datetime DEFAULT NULL COMMENT '调度-时间',
                                  `running_count` int NOT NULL DEFAULT '0' COMMENT '运行中-日志数量',
                                  `suc_count` int NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
                                  `fail_count` int NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
                                  PRIMARY KEY (`id`) USING BTREE,
                                  UNIQUE KEY `i_trigger_day` (`trigger_day`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `job_log_report`
--

LOCK TABLES `job_log_report` WRITE;
INSERT INTO `job_log_report` VALUES (20,'2019-12-07 00:00:00',0,0,0),(21,'2019-12-10 00:00:00',77,52,23),(22,'2019-12-11 00:00:00',9,2,11),(23,'2019-12-13 00:00:00',9,48,74),(24,'2019-12-12 00:00:00',10,8,30),(25,'2019-12-14 00:00:00',78,45,66),(26,'2019-12-15 00:00:00',24,76,9),(27,'2019-12-16 00:00:00',23,85,10),(28,'2023-04-26 00:00:00',0,0,1),(29,'2023-04-25 00:00:00',0,0,0),(30,'2023-04-24 00:00:00',0,0,0),(31,'2023-04-27 00:00:00',0,0,3);
UNLOCK TABLES;

--
-- Table structure for table `job_logglue`
--

DROP TABLE IF EXISTS `job_logglue`;
CREATE TABLE `job_logglue` (
                               `id` int NOT NULL AUTO_INCREMENT,
                               `job_id` int NOT NULL COMMENT '任务，主键ID',
                               `glue_type` varchar(50)  DEFAULT NULL COMMENT 'GLUE类型',
                               `glue_source` mediumtext  COMMENT 'GLUE源代码',
                               `glue_remark` varchar(128)  NOT NULL COMMENT 'GLUE备注',
                               `add_time` datetime DEFAULT NULL,
                               `update_time` datetime DEFAULT NULL,
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_permission`
--

DROP TABLE IF EXISTS `job_permission`;
CREATE TABLE `job_permission` (
                                  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `name` varchar(50)  NOT NULL COMMENT '权限名',
                                  `description` varchar(11)  DEFAULT NULL COMMENT '权限描述',
                                  `url` varchar(255)  DEFAULT NULL,
                                  `pid` int DEFAULT NULL,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_project`
--

DROP TABLE IF EXISTS `job_project`;
CREATE TABLE `job_project` (
                               `id` int NOT NULL AUTO_INCREMENT COMMENT 'key',
                               `name` varchar(100)  DEFAULT NULL COMMENT 'project name',
                               `description` varchar(200)  DEFAULT NULL,
                               `user_id` int DEFAULT NULL COMMENT 'creator id',
                               `flag` tinyint DEFAULT '1' COMMENT '0 not available, 1 available',
                               `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
                               `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'update time',
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_registry`
--

DROP TABLE IF EXISTS `job_registry`;
CREATE TABLE `job_registry` (
                                `id` int NOT NULL AUTO_INCREMENT,
                                `registry_group` varchar(50)  NOT NULL,
                                `registry_key` varchar(191)  NOT NULL,
                                `registry_value` varchar(191)  NOT NULL,
                                `cpu_usage` double DEFAULT NULL,
                                `memory_usage` double DEFAULT NULL,
                                `load_average` double DEFAULT NULL,
                                `update_time` datetime DEFAULT NULL,
                                PRIMARY KEY (`id`) USING BTREE,
                                KEY `i_g_k_v` (`registry_group`,`registry_key`,`registry_value`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_template`
--

DROP TABLE IF EXISTS `job_template`;
CREATE TABLE `job_template` (
                                `id` int NOT NULL AUTO_INCREMENT,
                                `job_group` int NOT NULL COMMENT '执行器主键ID',
                                `job_cron` varchar(128)  NOT NULL COMMENT '任务执行CRON',
                                `job_desc` varchar(255)  NOT NULL,
                                `add_time` datetime DEFAULT NULL,
                                `update_time` datetime DEFAULT NULL,
                                `user_id` int NOT NULL COMMENT '修改用户',
                                `alarm_email` varchar(255)  DEFAULT NULL COMMENT '报警邮件',
                                `executor_route_strategy` varchar(50)  DEFAULT NULL COMMENT '执行器路由策略',
                                `executor_handler` varchar(255)  DEFAULT NULL COMMENT '执行器任务handler',
                                `executor_param` varchar(512)  DEFAULT NULL COMMENT '执行器参数',
                                `executor_block_strategy` varchar(50)  DEFAULT NULL COMMENT '阻塞处理策略',
                                `executor_timeout` int NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
                                `executor_fail_retry_count` int NOT NULL DEFAULT '0' COMMENT '失败重试次数',
                                `glue_type` varchar(50)  NOT NULL COMMENT 'GLUE类型',
                                `glue_source` mediumtext  COMMENT 'GLUE源代码',
                                `glue_remark` varchar(128)  DEFAULT NULL COMMENT 'GLUE备注',
                                `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
                                `child_jobid` varchar(255)  DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
                                `trigger_last_time` bigint NOT NULL DEFAULT '0' COMMENT '上次调度时间',
                                `trigger_next_time` bigint NOT NULL DEFAULT '0' COMMENT '下次调度时间',
                                `job_json` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'datax运行脚本',
                                `jvm_param` varchar(200)  DEFAULT NULL COMMENT 'jvm参数',
                                `project_id` int DEFAULT NULL COMMENT '所属项目Id',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `job_user`
--

DROP TABLE IF EXISTS `job_user`;
CREATE TABLE `job_user` (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `username` varchar(50)  NOT NULL COMMENT '账号',
                            `password` varchar(100)  NOT NULL COMMENT '密码',
                            `role` varchar(50)  DEFAULT NULL COMMENT '角色：0-普通用户、1-管理员',
                            `permission` varchar(255)  DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
                            PRIMARY KEY (`id`) USING BTREE,
                            UNIQUE KEY `i_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `job_user`
--

LOCK TABLES `job_user` WRITE;
INSERT INTO `job_user` VALUES (1, 'admin', '$2a$10$RHIGXnCMYweUudm8mnWzn.pRSOpGrKLYEDMKy2v1GSW.TFNDhZgSq', 'ROLE_ADMIN', NULL);
UNLOCK TABLES;
