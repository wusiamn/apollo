
CREATE SCHEMA "ApolloConfigDB";
SET SEARCH_PATH TO "ApolloConfigDB";
DROP TABLE IF EXISTS "App";

CREATE TABLE "App" (
                       "Id" SERIAL PRIMARY KEY,                              -- 主键，使用 SERIAL
                       "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',       -- AppID
                       "Name" VARCHAR(500) NOT NULL DEFAULT 'default',       -- 应用名
                       "OrgId" VARCHAR(32) NOT NULL DEFAULT 'default',       -- 部门Id
                       "OrgName" VARCHAR(64) NOT NULL DEFAULT 'default',     -- 部门名字
                       "OwnerName" VARCHAR(500) NOT NULL DEFAULT 'default',  -- ownerName
                       "OwnerEmail" VARCHAR(500) NOT NULL DEFAULT 'default', -- ownerEmail
                       "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,           -- 1: deleted, 0: normal
                       "DeletedAt" BIGINT NOT NULL DEFAULT 0,                -- Delete timestamp based on milliseconds
                       "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default', -- 创建人邮箱前缀
                       "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                       "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',   -- 最后修改人邮箱前缀
                       "DataChange_LastTime" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, -- 最后修改时间

                       UNIQUE ("AppId", "DeletedAt")
);

-- 添加表的注释
COMMENT ON TABLE "App" IS '应用表';

-- 索引创建
CREATE INDEX "App_DataChange_LastTime_IDX" ON "App" ("DataChange_LastTime");
CREATE INDEX "App_Name_IDX" ON "App" ("Name");

-- 为列添加注释
COMMENT ON COLUMN "App"."Id" IS '主键';
COMMENT ON COLUMN "App"."AppId" IS 'AppID';
COMMENT ON COLUMN "App"."Name" IS '应用名';
COMMENT ON COLUMN "App"."OrgId" IS '部门Id';
COMMENT ON COLUMN "App"."OrgName" IS '部门名字';
COMMENT ON COLUMN "App"."OwnerName" IS 'ownerName';
COMMENT ON COLUMN "App"."OwnerEmail" IS 'ownerEmail';
COMMENT ON COLUMN "App"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "App"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "App"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "App"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "App"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "App"."DataChange_LastTime" IS '最后修改时间';



-- Dump of table appnamespace
-- ------------------------------------------------------------
DROP TABLE IF EXISTS "AppNamespace";

CREATE TABLE "AppNamespace" (
                                "Id" SERIAL PRIMARY KEY,                              -- 自增主键
                                "Name" VARCHAR(32) NOT NULL DEFAULT '',              -- namespace名字，需全局唯一
                                "AppId" VARCHAR(64) NOT NULL DEFAULT '',             -- app id
                                "Format" VARCHAR(32) NOT NULL DEFAULT 'properties',  -- namespace的format类型
                                "IsPublic" BOOLEAN NOT NULL DEFAULT FALSE,           -- namespace是否为公共
                                "Comment" VARCHAR(64) NOT NULL DEFAULT '',           -- 注释
                                "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,          -- 1: deleted, 0: normal
                                "DeletedAt" BIGINT NOT NULL DEFAULT 0,               -- 删除时间戳（毫秒）
                                "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default', -- 创建人邮箱前缀
                                "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                                "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                                "DataChange_LastTime" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, -- 最后修改时间

                                UNIQUE ("AppId", "Name", "DeletedAt")
);

-- 创建索引
CREATE INDEX "AppNamespace_Name_AppId_IDX" ON "AppNamespace" ("Name", "AppId");
CREATE INDEX "AppNamespace_DataChange_LastTime_IDX" ON "AppNamespace" ("DataChange_LastTime");

-- 添加列的注释
COMMENT ON COLUMN "AppNamespace"."Id" IS '自增主键';
COMMENT ON COLUMN "AppNamespace"."Name" IS 'namespace名字，需全局唯一';
COMMENT ON COLUMN "AppNamespace"."AppId" IS 'app id';
COMMENT ON COLUMN "AppNamespace"."Format" IS 'namespace的format类型';
COMMENT ON COLUMN "AppNamespace"."IsPublic" IS 'namespace是否为公共';
COMMENT ON COLUMN "AppNamespace"."Comment" IS '注释';
COMMENT ON COLUMN "AppNamespace"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "AppNamespace"."DeletedAt" IS '删除时间戳（毫秒）';
COMMENT ON COLUMN "AppNamespace"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AppNamespace"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AppNamespace"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AppNamespace"."DataChange_LastTime" IS '最后修改时间';

-- 添加表的注释
COMMENT ON TABLE "AppNamespace" IS '应用namespace定义';



-- Dump of table audit
-- ------------------------------------------------------------
DROP TABLE IF EXISTS "Audit";

CREATE TABLE "Audit" (
                         "Id" SERIAL PRIMARY KEY,                                -- 主键
                         "EntityName" VARCHAR(50) NOT NULL DEFAULT 'default',    -- 表名
                         "EntityId" INT DEFAULT NULL,                            -- 记录ID
                         "OpName" VARCHAR(50) NOT NULL DEFAULT 'default',        -- 操作类型
                         "Comment" VARCHAR(500) DEFAULT NULL,                    -- 备注
                         "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,             -- 1: deleted, 0: normal
                         "DeletedAt" BIGINT NOT NULL DEFAULT 0,                  -- 删除时间戳（毫秒）
                         "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default', -- 创建人邮箱前缀
                         "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                         "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',     -- 最后修改人邮箱前缀
                         "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 最后修改时间
);

-- 添加表的注释
COMMENT ON TABLE "Audit" IS '日志审计表';

-- 添加列的注释
COMMENT ON COLUMN "Audit"."Id" IS '主键';
COMMENT ON COLUMN "Audit"."EntityName" IS '表名';
COMMENT ON COLUMN "Audit"."EntityId" IS '记录ID';
COMMENT ON COLUMN "Audit"."OpName" IS '操作类型';
COMMENT ON COLUMN "Audit"."Comment" IS '备注';
COMMENT ON COLUMN "Audit"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Audit"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Audit"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Audit"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Audit"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Audit"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "idx_DataChange_LastTime_Audit" ON "Audit" ("DataChange_LastTime");



-- Dump of table cluster
-- ------------------------------------------------------------
DROP TABLE IF EXISTS "Cluster";

CREATE TABLE "Cluster" (
                           "Id" SERIAL PRIMARY KEY,                                    -- 自增主键
                           "Name" VARCHAR(32) NOT NULL DEFAULT '',                      -- 集群名字
                           "AppId" VARCHAR(64) NOT NULL DEFAULT '',                     -- App id
                           "ParentClusterId" INT NOT NULL DEFAULT 0,                    -- 父cluster
                           "Comment" VARCHAR(64) DEFAULT NULL,                          -- 备注
                           "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                  -- 1: deleted, 0: normal
                           "DeletedAt" BIGINT NOT NULL DEFAULT 0,                       -- 删除时间戳（毫秒）
                           "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default', -- 创建人邮箱前缀
                           "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                           "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',          -- 最后修改人邮箱前缀
                           "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP   -- 最后修改时间
);

-- 添加表的注释
COMMENT ON TABLE "Cluster" IS '集群';

-- 添加列的注释
COMMENT ON COLUMN "Cluster"."Id" IS '自增主键';
COMMENT ON COLUMN "Cluster"."Name" IS '集群名字';
COMMENT ON COLUMN "Cluster"."AppId" IS 'App id';
COMMENT ON COLUMN "Cluster"."ParentClusterId" IS '父cluster';
COMMENT ON COLUMN "Cluster"."Comment" IS '备注';
COMMENT ON COLUMN "Cluster"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Cluster"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Cluster"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Cluster"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Cluster"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Cluster"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_AppId_Name_DeletedAt" ON "Cluster" ("AppId", "Name", "DeletedAt");

-- 创建普通索引
CREATE INDEX "IX_ParentClusterId" ON "Cluster" ("ParentClusterId");
CREATE INDEX "idx_DataChange_LastTime_Cluster" ON "Cluster" ("DataChange_LastTime");



-- Dump of table commit
-- ------------------------------------------------------------
DROP TABLE IF EXISTS "Commit";

CREATE TABLE "Commit" (
                          "Id" SERIAL PRIMARY KEY,                                         -- 主键
                          "ChangeSets" TEXT NOT NULL,                                       -- 修改变更集
                          "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                   -- AppID
                          "ClusterName" VARCHAR(500) NOT NULL DEFAULT 'default',            -- ClusterName
                          "NamespaceName" VARCHAR(500) NOT NULL DEFAULT 'default',          -- namespaceName
                          "Comment" VARCHAR(500) DEFAULT NULL,                              -- 备注
                          "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                       -- 1: deleted, 0: normal
                          "DeletedAt" BIGINT NOT NULL DEFAULT 0,                            -- 删除时间戳（毫秒）
                          "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',    -- 创建人邮箱前缀
                          "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                          "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',              -- 最后修改人邮箱前缀
                          "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP        -- 最后修改时间
);

-- 添加表的注释
COMMENT ON TABLE "Commit" IS 'commit 历史表';

-- 添加列的注释
COMMENT ON COLUMN "Commit"."Id" IS '主键';
COMMENT ON COLUMN "Commit"."ChangeSets" IS '修改变更集';
COMMENT ON COLUMN "Commit"."AppId" IS 'AppID';
COMMENT ON COLUMN "Commit"."ClusterName" IS 'ClusterName';
COMMENT ON COLUMN "Commit"."NamespaceName" IS 'namespaceName';
COMMENT ON COLUMN "Commit"."Comment" IS '备注';
COMMENT ON COLUMN "Commit"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Commit"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Commit"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Commit"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Commit"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Commit"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "idx_DataChange_LastTime_Commit" ON "Commit" ("DataChange_LastTime");
CREATE INDEX "idx_AppId" ON "Commit" ("AppId");
CREATE INDEX "idx_ClusterName" ON "Commit" ("ClusterName");
CREATE INDEX "idx_NamespaceName" ON "Commit" ("NamespaceName");

-- Dump of table grayreleaserule
-- ------------------------------------------------------------
DROP TABLE IF EXISTS "GrayReleaseRule";

CREATE TABLE "GrayReleaseRule" (
                                   "Id" SERIAL PRIMARY KEY,                                             -- 主键
                                   "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                       -- AppID
                                   "ClusterName" VARCHAR(32) NOT NULL DEFAULT 'default',                 -- Cluster Name
                                   "NamespaceName" VARCHAR(32) NOT NULL DEFAULT 'default',               -- Namespace Name
                                   "BranchName" VARCHAR(32) NOT NULL DEFAULT 'default',                  -- branch name
                                   "Rules" VARCHAR(16000) DEFAULT '[]',                                  -- 灰度规则
                                   "ReleaseId" INT NOT NULL DEFAULT 0,                                   -- 灰度对应的release
                                   "BranchStatus" SMALLINT DEFAULT 1,                                    -- 灰度分支状态
                                   "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                           -- 1: deleted, 0: normal
                                   "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                -- 删除时间戳（毫秒）
                                   "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',        -- 创建人邮箱前缀
                                   "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                                   "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                  -- 最后修改人邮箱前缀
                                   "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP            -- 最后修改时间
);

-- 添加表的注释
COMMENT ON TABLE "GrayReleaseRule" IS '灰度规则表';

-- 添加列的注释
COMMENT ON COLUMN "GrayReleaseRule"."Id" IS '主键';
COMMENT ON COLUMN "GrayReleaseRule"."AppId" IS 'AppID';
COMMENT ON COLUMN "GrayReleaseRule"."ClusterName" IS 'Cluster Name';
COMMENT ON COLUMN "GrayReleaseRule"."NamespaceName" IS 'Namespace Name';
COMMENT ON COLUMN "GrayReleaseRule"."BranchName" IS 'branch name';
COMMENT ON COLUMN "GrayReleaseRule"."Rules" IS '灰度规则';
COMMENT ON COLUMN "GrayReleaseRule"."ReleaseId" IS '灰度对应的release';
COMMENT ON COLUMN "GrayReleaseRule"."BranchStatus" IS '灰度分支状态: 0:删除分支, 1:正在使用的规则, 2:全量发布';
COMMENT ON COLUMN "GrayReleaseRule"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "GrayReleaseRule"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "GrayReleaseRule"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "GrayReleaseRule"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "GrayReleaseRule"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "GrayReleaseRule"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "idx_DataChange_LastTime_GrayReleaseRule" ON "GrayReleaseRule" ("DataChange_LastTime");
CREATE INDEX "idx_Namespace" ON "GrayReleaseRule" ("AppId", "ClusterName", "NamespaceName");


-- Dump of table instance
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "Instance";

CREATE TABLE "Instance" (
                            "Id" SERIAL PRIMARY KEY,                                          -- 自增Id
                            "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                    -- AppID
                            "ClusterName" VARCHAR(32) NOT NULL DEFAULT 'default',              -- ClusterName
                            "DataCenter" VARCHAR(64) NOT NULL DEFAULT 'default',               -- Data Center Name
                            "Ip" VARCHAR(32) NOT NULL DEFAULT '',                              -- instance ip
                            "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                            "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- 最后修改时间
);

-- 添加表的注释
COMMENT ON TABLE "Instance" IS '使用配置的应用实例';

-- 添加列的注释
COMMENT ON COLUMN "Instance"."Id" IS '自增Id';
COMMENT ON COLUMN "Instance"."AppId" IS 'AppID';
COMMENT ON COLUMN "Instance"."ClusterName" IS 'ClusterName';
COMMENT ON COLUMN "Instance"."DataCenter" IS 'Data Center Name';
COMMENT ON COLUMN "Instance"."Ip" IS 'instance ip';
COMMENT ON COLUMN "Instance"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Instance"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "IX_UNIQUE_KEY_Instance" ON "Instance" ("AppId", "ClusterName", "Ip", "DataCenter");

-- 创建普通索引
CREATE INDEX "IX_IP" ON "Instance" ("Ip");
CREATE INDEX "IX_DataChange_LastTime_Instance" ON "Instance" ("DataChange_LastTime");



-- Dump of table instanceconfig
-- ------------------------------------------------------------

-- 删除表（如果存在）
DROP TABLE IF EXISTS "InstanceConfig";

-- 创建表
CREATE TABLE "InstanceConfig" (
                                  "Id" SERIAL PRIMARY KEY,                                            -- 自增Id
                                  "InstanceId" INTEGER,                                               -- Instance Id
                                  "ConfigAppId" VARCHAR(64) NOT NULL DEFAULT 'default',               -- Config App Id
                                  "ConfigClusterName" VARCHAR(32) NOT NULL DEFAULT 'default',         -- Config Cluster Name
                                  "ConfigNamespaceName" VARCHAR(32) NOT NULL DEFAULT 'default',       -- Config Namespace Name
                                  "ReleaseKey" VARCHAR(64) NOT NULL DEFAULT '',                       -- 发布的Key
                                  "ReleaseDeliveryTime" TIMESTAMP NULL DEFAULT NULL,                  -- 配置获取时间
                                  "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                                  "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 创建索引
CREATE UNIQUE INDEX "IX_UNIQUE_KEY_InstanceConfig" ON "InstanceConfig" ("InstanceId", "ConfigAppId", "ConfigNamespaceName");
CREATE INDEX "IX_ReleaseKey" ON "InstanceConfig" ("ReleaseKey");
CREATE INDEX "IX_DataChange_LastTime" ON "InstanceConfig" ("DataChange_LastTime");
CREATE INDEX "IX_Valid_Namespace" ON "InstanceConfig" ("ConfigAppId", "ConfigClusterName", "ConfigNamespaceName", "DataChange_LastTime");

-- 添加表和列的注释
COMMENT ON TABLE "InstanceConfig" IS '应用实例的配置信息';
COMMENT ON COLUMN "InstanceConfig"."Id" IS '自增Id';
COMMENT ON COLUMN "InstanceConfig"."InstanceId" IS 'Instance Id';
COMMENT ON COLUMN "InstanceConfig"."ConfigAppId" IS 'Config App Id';
COMMENT ON COLUMN "InstanceConfig"."ConfigClusterName" IS 'Config Cluster Name';
COMMENT ON COLUMN "InstanceConfig"."ConfigNamespaceName" IS 'Config Namespace Name';
COMMENT ON COLUMN "InstanceConfig"."ReleaseKey" IS '发布的Key';
COMMENT ON COLUMN "InstanceConfig"."ReleaseDeliveryTime" IS '配置获取时间';
COMMENT ON COLUMN "InstanceConfig"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "InstanceConfig"."DataChange_LastTime" IS '最后修改时间';



-- Dump of table item
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "Item";

-- 创建表 Item
CREATE TABLE "Item" (
                        "Id" SERIAL PRIMARY KEY,                                             -- 自增Id
                        "NamespaceId" INT NOT NULL DEFAULT 0,                                 -- 集群NamespaceId
                        "Key" VARCHAR(128) NOT NULL DEFAULT 'default',                        -- 配置项Key
                        "Type" SMALLINT NOT NULL DEFAULT 0,                                    -- 配置项类型，0: String，1: Number，2: Boolean，3: JSON
                        "Value" TEXT NOT NULL,                                                -- 配置项值
                        "Comment" VARCHAR(1024) DEFAULT '',                                   -- 注释
                        "LineNum" INT DEFAULT 0,                                              -- 行号
                        "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                           -- 1: deleted, 0: normal
                        "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                -- 删除时间戳（毫秒）
                        "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',        -- 创建人邮箱前缀
                        "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                        "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                  -- 最后修改人邮箱前缀
                        "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP            -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "Item" IS '配置项目';
COMMENT ON COLUMN "Item"."Id" IS '自增Id';
COMMENT ON COLUMN "Item"."NamespaceId" IS '集群NamespaceId';
COMMENT ON COLUMN "Item"."Key" IS '配置项Key';
COMMENT ON COLUMN "Item"."Type" IS '配置项类型，0: String，1: Number，2: Boolean，3: JSON';
COMMENT ON COLUMN "Item"."Value" IS '配置项值';
COMMENT ON COLUMN "Item"."Comment" IS '注释';
COMMENT ON COLUMN "Item"."LineNum" IS '行号';
COMMENT ON COLUMN "Item"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Item"."DeletedAt" IS '删除时间戳（毫秒）';
COMMENT ON COLUMN "Item"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Item"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Item"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Item"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "IX_NamespaceId" ON "Item" ("NamespaceId");
CREATE INDEX "IX_DataChange_LastTime_Item" ON "Item" ("DataChange_LastTime");



-- Dump of table namespace
-- ------------------------------------------------------------

DROP TABLE IF EXISTS "Namespace";

-- 创建表 Namespace
CREATE TABLE "Namespace" (
                             "Id" SERIAL PRIMARY KEY,                                             -- 自增主键
                             "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                      -- AppID
                             "ClusterName" VARCHAR(500) NOT NULL DEFAULT 'default',               -- Cluster Name
                             "NamespaceName" VARCHAR(500) NOT NULL DEFAULT 'default',             -- Namespace Name
                             "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                          -- 1: deleted, 0: normal
                             "DeletedAt" BIGINT NOT NULL DEFAULT 0,                               -- 删除时间戳（毫秒）
                             "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',       -- 创建人邮箱前缀
                             "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 创建时间
                             "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                 -- 最后修改人邮箱前缀
                             "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP           -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "Namespace" IS '命名空间';
COMMENT ON COLUMN "Namespace"."Id" IS '自增主键';
COMMENT ON COLUMN "Namespace"."AppId" IS 'AppID';
COMMENT ON COLUMN "Namespace"."ClusterName" IS 'Cluster Name';
COMMENT ON COLUMN "Namespace"."NamespaceName" IS 'Namespace Name';
COMMENT ON COLUMN "Namespace"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Namespace"."DeletedAt" IS '删除时间戳（毫秒）';
COMMENT ON COLUMN "Namespace"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Namespace"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Namespace"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Namespace"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE UNIQUE INDEX "UK_AppId_ClusterName_NamespaceName_DeletedAt" ON "Namespace" ("AppId", "ClusterName", "NamespaceName", "DeletedAt");
CREATE INDEX "IX_DataChange_LastTime_Namespace" ON "Namespace" ("DataChange_LastTime");
CREATE INDEX "IX_NamespaceName" ON "Namespace" ("NamespaceName");



-- Dump of table namespacelock
-- ------------------------------------------------------------

-- 删除表 NamespaceLock
DROP TABLE IF EXISTS "NamespaceLock";

-- 创建表 NamespaceLock
CREATE TABLE "NamespaceLock" (
                                 "Id" SERIAL PRIMARY KEY,                                                -- 自增ID
                                 "NamespaceId" INT NOT NULL DEFAULT 0,                                    -- 集群NamespaceId
                                 "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',           -- 创建人邮箱前缀
                                 "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- 创建时间
                                 "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                     -- 最后修改人邮箱前缀
                                 "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,              -- 最后修改时间
                                 "IsDeleted" BOOLEAN DEFAULT FALSE,                                       -- 软删除
                                 "DeletedAt" BIGINT NOT NULL DEFAULT 0                                    -- 删除时间戳（毫秒）
);

-- 添加表和列的注释
COMMENT ON TABLE "NamespaceLock" IS 'namespace的编辑锁';
COMMENT ON COLUMN "NamespaceLock"."Id" IS '自增id';
COMMENT ON COLUMN "NamespaceLock"."NamespaceId" IS '集群NamespaceId';
COMMENT ON COLUMN "NamespaceLock"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "NamespaceLock"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "NamespaceLock"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "NamespaceLock"."DataChange_LastTime" IS '最后修改时间';
COMMENT ON COLUMN "NamespaceLock"."IsDeleted" IS '软删除';
COMMENT ON COLUMN "NamespaceLock"."DeletedAt" IS '删除时间戳（毫秒）';

-- 创建索引
CREATE UNIQUE INDEX "UK_NamespaceId_DeletedAt" ON "NamespaceLock" ("NamespaceId", "DeletedAt");
CREATE INDEX "IX_DataChange_LastTime_NamespaceLock" ON "NamespaceLock" ("DataChange_LastTime");



-- Dump of table release
-- ------------------------------------------------------------

-- 删除表 Release
DROP TABLE IF EXISTS "Release";

-- 创建表 Release
CREATE TABLE "Release" (
                           "Id" SERIAL PRIMARY KEY,                                                 -- 自增主键
                           "ReleaseKey" VARCHAR(64) NOT NULL DEFAULT '',                            -- 发布的Key
                           "Name" VARCHAR(64) NOT NULL DEFAULT 'default',                           -- 发布名字
                           "Comment" VARCHAR(256) DEFAULT NULL,                                     -- 发布说明
                           "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                          -- AppID
                           "ClusterName" VARCHAR(500) NOT NULL DEFAULT 'default',                   -- ClusterName
                           "NamespaceName" VARCHAR(500) NOT NULL DEFAULT 'default',                 -- namespaceName
                           "Configurations" TEXT NOT NULL,                                          -- 发布配置
                           "IsAbandoned" BOOLEAN NOT NULL DEFAULT FALSE,                            -- 是否废弃
                           "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                              -- 1: deleted, 0: normal
                           "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                   -- 删除时间戳（毫秒）
                           "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',          -- 创建人邮箱前缀
                           "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                           "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                     -- 最后修改人邮箱前缀
                           "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP              -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "Release" IS '发布';
COMMENT ON COLUMN "Release"."Id" IS '自增主键';
COMMENT ON COLUMN "Release"."ReleaseKey" IS '发布的Key';
COMMENT ON COLUMN "Release"."Name" IS '发布名字';
COMMENT ON COLUMN "Release"."Comment" IS '发布说明';
COMMENT ON COLUMN "Release"."AppId" IS 'AppID';
COMMENT ON COLUMN "Release"."ClusterName" IS 'ClusterName';
COMMENT ON COLUMN "Release"."NamespaceName" IS 'namespaceName';
COMMENT ON COLUMN "Release"."Configurations" IS '发布配置';
COMMENT ON COLUMN "Release"."IsAbandoned" IS '是否废弃';
COMMENT ON COLUMN "Release"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Release"."DeletedAt" IS '删除时间戳（毫秒）';
COMMENT ON COLUMN "Release"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Release"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Release"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Release"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE UNIQUE INDEX "UK_ReleaseKey_DeletedAt" ON "Release" ("ReleaseKey", "DeletedAt");
CREATE INDEX "AppId_ClusterName_GroupName" ON "Release" ("AppId", "ClusterName", "NamespaceName");
CREATE INDEX "DataChange_LastTime" ON "Release" ("DataChange_LastTime");


-- Dump of table releasehistory
-- ------------------------------------------------------------
-- 删除表 ReleaseHistory
DROP TABLE IF EXISTS "ReleaseHistory";

-- 创建表 ReleaseHistory
CREATE TABLE "ReleaseHistory" (
                                  "Id" SERIAL PRIMARY KEY,                                                 -- 自增Id
                                  "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                          -- AppID
                                  "ClusterName" VARCHAR(32) NOT NULL DEFAULT 'default',                    -- ClusterName
                                  "NamespaceName" VARCHAR(32) NOT NULL DEFAULT 'default',                  -- namespaceName
                                  "BranchName" VARCHAR(32) NOT NULL DEFAULT 'default',                     -- 发布分支名
                                  "ReleaseId" INT NOT NULL DEFAULT 0,                                       -- 关联的Release Id
                                  "PreviousReleaseId" INT NOT NULL DEFAULT 0,                               -- 前一次发布的ReleaseId
                                  "Operation" SMALLINT NOT NULL DEFAULT 0,                                  -- 发布类型
                                  "OperationContext" TEXT NOT NULL,                                        -- 发布上下文信息
                                  "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                               -- 1: deleted, 0: normal
                                  "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                    -- 删除时间戳（毫秒）
                                  "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',           -- 创建人邮箱前缀
                                  "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,   -- 创建时间
                                  "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                      -- 最后修改人邮箱前缀
                                  "DataChange_LastTime" TIMESTAMP DEFAULT CURRENT_TIMESTAMP               -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "ReleaseHistory" IS '发布历史';
COMMENT ON COLUMN "ReleaseHistory"."Id" IS '自增Id';
COMMENT ON COLUMN "ReleaseHistory"."AppId" IS 'AppID';
COMMENT ON COLUMN "ReleaseHistory"."ClusterName" IS 'ClusterName';
COMMENT ON COLUMN "ReleaseHistory"."NamespaceName" IS 'namespaceName';
COMMENT ON COLUMN "ReleaseHistory"."BranchName" IS '发布分支名';
COMMENT ON COLUMN "ReleaseHistory"."ReleaseId" IS '关联的Release Id';
COMMENT ON COLUMN "ReleaseHistory"."PreviousReleaseId" IS '前一次发布的ReleaseId';
COMMENT ON COLUMN "ReleaseHistory"."Operation" IS '发布类型';
COMMENT ON COLUMN "ReleaseHistory"."OperationContext" IS '发布上下文信息';
COMMENT ON COLUMN "ReleaseHistory"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "ReleaseHistory"."DeletedAt" IS '删除时间戳（毫秒）';
COMMENT ON COLUMN "ReleaseHistory"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "ReleaseHistory"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ReleaseHistory"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "ReleaseHistory"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "IX_Namespace" ON "ReleaseHistory" ("AppId", "ClusterName", "NamespaceName", "BranchName");
CREATE INDEX "IX_ReleaseId" ON "ReleaseHistory" ("ReleaseId");
CREATE INDEX "IX_DataChange_LastTime_ReleaseHistory" ON "ReleaseHistory" ("DataChange_LastTime");
CREATE INDEX "IX_PreviousReleaseId" ON "ReleaseHistory" ("PreviousReleaseId");


-- Dump of table releasemessage
-- ------------------------------------------------------------

-- 删除表 ReleaseMessage
DROP TABLE IF EXISTS "ReleaseMessage";

-- 创建表 ReleaseMessage
CREATE TABLE "ReleaseMessage" (
                                  "Id" SERIAL PRIMARY KEY,                                                 -- 自增主键
                                  "Message" VARCHAR(1024) NOT NULL DEFAULT '',                             -- 发布的消息内容
                                  "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP      -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "ReleaseMessage" IS '发布消息';
COMMENT ON COLUMN "ReleaseMessage"."Id" IS '自增主键';
COMMENT ON COLUMN "ReleaseMessage"."Message" IS '发布的消息内容';
COMMENT ON COLUMN "ReleaseMessage"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "DataChange_LastTime_ReleaseMessage" ON "ReleaseMessage" ("DataChange_LastTime");
CREATE INDEX "IX_Message" ON "ReleaseMessage" ("Message");


-- Dump of table serverconfig
-- ------------------------------------------------------------

-- 删除表 ServerConfig
DROP TABLE IF EXISTS "ServerConfig";

-- 创建表 ServerConfig
CREATE TABLE "ServerConfig" (
                                "Id" SERIAL PRIMARY KEY,                                                     -- 自增Id
                                "Key" VARCHAR(64) NOT NULL DEFAULT 'default',                                -- 配置项Key
                                "Cluster" VARCHAR(32) NOT NULL DEFAULT 'default',                            -- 配置对应的集群
                                "Value" VARCHAR(2048) NOT NULL DEFAULT 'default',                            -- 配置项值
                                "Comment" VARCHAR(1024) DEFAULT '',                                          -- 注释
                                "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                                  -- 删除标记
                                "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                       -- 删除时间
                                "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',              -- 创建人邮箱前缀
                                "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,      -- 创建时间
                                "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                        -- 最后修改人邮箱前缀
                                "DataChange_LastTime" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP              -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "ServerConfig" IS '配置服务自身配置';
COMMENT ON COLUMN "ServerConfig"."Id" IS '自增Id';
COMMENT ON COLUMN "ServerConfig"."Key" IS '配置项Key';
COMMENT ON COLUMN "ServerConfig"."Cluster" IS '配置对应的集群，default为不针对特定的集群';
COMMENT ON COLUMN "ServerConfig"."Value" IS '配置项值';
COMMENT ON COLUMN "ServerConfig"."Comment" IS '注释';
COMMENT ON COLUMN "ServerConfig"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "ServerConfig"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "ServerConfig"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "ServerConfig"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ServerConfig"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "ServerConfig"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_Key_Cluster_DeletedAt" ON "ServerConfig" ("Key", "Cluster", "DeletedAt");

-- 创建索引
CREATE INDEX "DataChange_LastTime_ServerConfig" ON "ServerConfig" ("DataChange_LastTime");

-- Dump of table accesskey
-- ------------------------------------------------------------

-- 删除表 AccessKey
DROP TABLE IF EXISTS "AccessKey";

-- 创建表 AccessKey
CREATE TABLE "AccessKey" (
                             "Id" SERIAL PRIMARY KEY,                                                       -- 自增主键
                             "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',                                 -- AppID
                             "Secret" VARCHAR(128) NOT NULL DEFAULT '',                                      -- Secret
                             "Mode" INT NOT NULL DEFAULT 0,                                                  -- 密钥模式，0: filter，1: observer
                             "IsEnabled" BOOLEAN NOT NULL DEFAULT FALSE,                                     -- 是否启用
                             "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                                     -- 删除标记
                             "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                          -- 删除时间
                             "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',                 -- 创建人邮箱前缀
                             "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,         -- 创建时间
                             "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                           -- 最后修改人邮箱前缀
                             "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP             -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "AccessKey" IS '访问密钥';
COMMENT ON COLUMN "AccessKey"."Id" IS '自增主键';
COMMENT ON COLUMN "AccessKey"."AppId" IS 'AppID';
COMMENT ON COLUMN "AccessKey"."Secret" IS 'Secret';
COMMENT ON COLUMN "AccessKey"."Mode" IS '密钥模式，0: filter，1: observer';
COMMENT ON COLUMN "AccessKey"."IsEnabled" IS '1: enabled, 0: disabled';
COMMENT ON COLUMN "AccessKey"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "AccessKey"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "AccessKey"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AccessKey"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AccessKey"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AccessKey"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_AppId_Secret_DeletedAt" ON "AccessKey" ("AppId", "Secret", "DeletedAt");

-- 创建索引
CREATE INDEX "DataChange_LastTime_AccessKey" ON "AccessKey" ("DataChange_LastTime");


-- Dump of table serviceregistry
-- ------------------------------------------------------------

-- 删除表 ServiceRegistry
DROP TABLE IF EXISTS "ServiceRegistry";

-- 创建表 ServiceRegistry
CREATE TABLE "ServiceRegistry" (
                                   "Id" SERIAL PRIMARY KEY,                                                   -- 自增主键
                                   "ServiceName" VARCHAR(64) NOT NULL,                                         -- 服务名
                                   "Uri" VARCHAR(64) NOT NULL,                                                 -- 服务地址
                                   "Cluster" VARCHAR(64) NOT NULL,                                             -- 集群，可以用来标识apollo.cluster或者网络分区
                                   "Metadata" VARCHAR(1024) NOT NULL DEFAULT '{}'::jsonb,                      -- 元数据，key value结构的json object，为了方便后面扩展功能而不需要修改表结构
                                   "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,      -- 创建时间
                                   "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP          -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "ServiceRegistry" IS '注册中心';
COMMENT ON COLUMN "ServiceRegistry"."Id" IS '自增Id';
COMMENT ON COLUMN "ServiceRegistry"."ServiceName" IS '服务名';
COMMENT ON COLUMN "ServiceRegistry"."Uri" IS '服务地址';
COMMENT ON COLUMN "ServiceRegistry"."Cluster" IS '集群，可以用来标识apollo.cluster或者网络分区';
COMMENT ON COLUMN "ServiceRegistry"."Metadata" IS '元数据，key value结构的json object，为了方便后面扩展功能而不需要修改表结构';
COMMENT ON COLUMN "ServiceRegistry"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ServiceRegistry"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "IX_UNIQUE_KEY_ServiceRegistry" ON "ServiceRegistry" ("ServiceName", "Uri");

-- 创建索引
CREATE INDEX "IX_DataChange_LastTime_ServiceRegistry" ON "ServiceRegistry" ("DataChange_LastTime");

-- Dump of table AuditLog
-- ------------------------------------------------------------
-- 删除表 AuditLog
DROP TABLE IF EXISTS "AuditLog";

-- 创建表 AuditLog
CREATE TABLE "AuditLog" (
                            "Id" SERIAL PRIMARY KEY,                                                   -- 主键
                            "TraceId" VARCHAR(32) NOT NULL DEFAULT '',                                 -- 链路全局唯一ID
                            "SpanId" VARCHAR(32) NOT NULL DEFAULT '',                                  -- 跨度ID
                            "ParentSpanId" VARCHAR(32) DEFAULT NULL,                                   -- 父跨度ID
                            "FollowsFromSpanId" VARCHAR(32) DEFAULT NULL,                              -- 上一个兄弟跨度ID
                            "Operator" VARCHAR(64) NOT NULL DEFAULT 'anonymous',                       -- 操作人
                            "OpType" VARCHAR(50) NOT NULL DEFAULT 'default',                           -- 操作类型
                            "OpName" VARCHAR(150) NOT NULL DEFAULT 'default',                          -- 操作名称
                            "Description" VARCHAR(200) DEFAULT NULL,                                   -- 备注
                            "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                                -- 1: deleted, 0: normal
                            "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                     -- Delete timestamp based on milliseconds
                            "DataChange_CreatedBy" VARCHAR(64) DEFAULT NULL,                           -- 创建人邮箱前缀
                            "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,     -- 创建时间
                            "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                        -- 最后修改人邮箱前缀
                            "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP         -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "AuditLog" IS '审计日志表';
COMMENT ON COLUMN "AuditLog"."Id" IS '主键';
COMMENT ON COLUMN "AuditLog"."TraceId" IS '链路全局唯一ID';
COMMENT ON COLUMN "AuditLog"."SpanId" IS '跨度ID';
COMMENT ON COLUMN "AuditLog"."ParentSpanId" IS '父跨度ID';
COMMENT ON COLUMN "AuditLog"."FollowsFromSpanId" IS '上一个兄弟跨度ID';
COMMENT ON COLUMN "AuditLog"."Operator" IS '操作人';
COMMENT ON COLUMN "AuditLog"."OpType" IS '操作类型';
COMMENT ON COLUMN "AuditLog"."OpName" IS '操作名称';
COMMENT ON COLUMN "AuditLog"."Description" IS '备注';
COMMENT ON COLUMN "AuditLog"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "AuditLog"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "AuditLog"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AuditLog"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AuditLog"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AuditLog"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "IX_TraceId" ON "AuditLog" ("TraceId");
CREATE INDEX "IX_OpName" ON "AuditLog" ("OpName");
CREATE INDEX "IX_DataChange_CreatedTime_AuditLog" ON "AuditLog" ("DataChange_CreatedTime");
CREATE INDEX "IX_Operator" ON "AuditLog" ("Operator");

-- Dump of table AuditLogDataInfluence
-- ------------------------------------------------------------
-- 删除表 AuditLogDataInfluence
DROP TABLE IF EXISTS "AuditLogDataInfluence";

-- 创建表 AuditLogDataInfluence
CREATE TABLE "AuditLogDataInfluence" (
                                         "Id" SERIAL PRIMARY KEY,                                                    -- 主键
                                         "SpanId" CHAR(32) NOT NULL DEFAULT '',                                       -- 跨度ID
                                         "InfluenceEntityId" VARCHAR(50) NOT NULL DEFAULT '0',                       -- 记录ID
                                         "InfluenceEntityName" VARCHAR(50) NOT NULL DEFAULT 'default',                -- 表名
                                         "FieldName" VARCHAR(50) DEFAULT NULL,                                        -- 字段名称
                                         "FieldOldValue" VARCHAR(500) DEFAULT NULL,                                   -- 字段旧值
                                         "FieldNewValue" VARCHAR(500) DEFAULT NULL,                                   -- 字段新值
                                         "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,                                  -- 1: deleted, 0: normal
                                         "DeletedAt" BIGINT NOT NULL DEFAULT 0,                                       -- Delete timestamp based on milliseconds
                                         "DataChange_CreatedBy" VARCHAR(64) DEFAULT NULL,                             -- 创建人邮箱前缀
                                         "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,       -- 创建时间
                                         "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',                          -- 最后修改人邮箱前缀
                                         "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP           -- 最后修改时间
);

-- 添加表和列的注释
COMMENT ON TABLE "AuditLogDataInfluence" IS '审计日志数据变动表';
COMMENT ON COLUMN "AuditLogDataInfluence"."Id" IS '主键';
COMMENT ON COLUMN "AuditLogDataInfluence"."SpanId" IS '跨度ID';
COMMENT ON COLUMN "AuditLogDataInfluence"."InfluenceEntityId" IS '记录ID';
COMMENT ON COLUMN "AuditLogDataInfluence"."InfluenceEntityName" IS '表名';
COMMENT ON COLUMN "AuditLogDataInfluence"."FieldName" IS '字段名称';
COMMENT ON COLUMN "AuditLogDataInfluence"."FieldOldValue" IS '字段旧值';
COMMENT ON COLUMN "AuditLogDataInfluence"."FieldNewValue" IS '字段新值';
COMMENT ON COLUMN "AuditLogDataInfluence"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "AuditLogDataInfluence"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_LastTime" IS '最后修改时间';

-- 创建索引
CREATE INDEX "IX_SpanId" ON "AuditLogDataInfluence" ("SpanId");
CREATE INDEX "IX_DataChange_CreatedTime_AuditLogDataInfluence" ON "AuditLogDataInfluence" ("DataChange_CreatedTime");
CREATE INDEX "IX_EntityId" ON "AuditLogDataInfluence" ("InfluenceEntityId");

-- Config
-- ------------------------------------------------------------
INSERT INTO "ServerConfig" ("Key", "Cluster", "Value", "Comment", "DataChange_CreatedBy", "DataChange_CreatedTime")
VALUES
    ('eureka.service.url', 'default', 'http://localhost:8080/eureka/', 'Eureka服务Url，多个service以英文逗号分隔', 'default', CURRENT_TIMESTAMP),
    ('namespace.lock.switch', 'default', 'false', '一次发布只能有一个人修改开关', 'default', CURRENT_TIMESTAMP),
    ('item.key.length.limit', 'default', '128', 'item key 最大长度限制', 'default', CURRENT_TIMESTAMP),
    ('item.value.length.limit', 'default', '20000', 'item value最大长度限制', 'default', CURRENT_TIMESTAMP),
    ('config-service.cache.enabled', 'default', 'false', 'ConfigService是否开启缓存，开启后能提高性能，但是会增大内存消耗！', 'default', CURRENT_TIMESTAMP);

