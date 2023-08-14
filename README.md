# DataX-Web 个人小优化版
### 基于2.1.2

DataX Web是在DataX之上开发的分布式数据同步工具，提供简单易用的
操作界面，降低用户使用DataX的学习成本，缩短任务配置时间，避免配置过程中出错。用户可通过页面选择数据源即可创建数据同步任务，RDBMS数据源可批量创建数据同步任务，支持实时查看数据同步进度及日志并提供终止同步功能，集成并二次开发xxl-job可根据时间、自增主键增量同步数据。

任务"执行器"支持集群部署，支持执行器多节点路由策略选择，支持超时控制、失败重试、失败告警、任务依赖，执行器CPU.内存.负载的监控等等。后续还将提供更多的数据源支持、数据转换UDF、表结构同步、数据同步血缘等更为复杂的业务场景。

使用说明请见原仓库地址：https://github.com/WeiYe-Jing/datax-web

```shell
# 打包
mvn clean install
```

### 目前想到的优化点
- [x] 登录密文传输
- [X] 修改用户密码密文传输
- [ ] 数据源管理测试连接、提交密文传输
- [x] 数据源删除二次确认
- [x] 一键更改任务管理数据源（MySQL）
- [x] 通过配置禁用swagger（默认禁用，启用则配置swagger.enabled=true）

#
#### 一键更改任务管理数据源用法
如果是jdbc类型的数据源，提交修改后会弹出提示框，点击“确定”即可进入弹窗，替换的数据源会以刚刚修改的数据源为基准。

可以以项目或者任务的维度来选择更新列表。

以MySQL的JSON模板来开发，如果你使用的数据源模板中username、password、jdbc_url跟MySQL模板的节点位置是一样的，那么可以使用，位置不同请不要使用这个功能。

![dialog](https://github.com/fancy-xie/datax-web/blob/master/doc/datax-web/batch-update-job-datasource/dialog.png?raw=true)