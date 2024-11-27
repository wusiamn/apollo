
CREATE SCHEMA "ApolloPortalDB";
SET SEARCH_PATH TO "ApolloPortalDB";

-- 删除表 App
DROP TABLE IF EXISTS "App";

-- 创建表 "App"
CREATE TABLE "App" (
                       "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                       "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',  -- AppID
                       "Name" VARCHAR(500) NOT NULL DEFAULT 'default',  -- 应用名
                       "OrgId" VARCHAR(32) NOT NULL DEFAULT 'default',  -- 部门Id
                       "OrgName" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 部门名字
                       "OwnerName" VARCHAR(500) NOT NULL DEFAULT 'default',  -- ownerName
                       "OwnerEmail" VARCHAR(500) NOT NULL DEFAULT 'default',  -- ownerEmail
                       "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 bit(1)
                       "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                       "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                       "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                       "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                       "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "App" IS '应用表';
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

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_AppId_DeletedAt_App" ON "App" ("AppId", "DeletedAt");

-- 创建普通索引
CREATE INDEX "DataChange_LastTime_App" ON "App" ("DataChange_LastTime");
CREATE INDEX "IX_Name" ON "App" ("Name");

-- 删除表 AppNamespace
DROP TABLE IF EXISTS "AppNamespace";

-- 创建表 "AppNamespace"
CREATE TABLE "AppNamespace" (
                                "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                                "Name" VARCHAR(32) NOT NULL DEFAULT '',  -- namespace名字，注意，需要全局唯一
                                "AppId" VARCHAR(64) NOT NULL DEFAULT '',  -- app id
                                "Format" VARCHAR(32) NOT NULL DEFAULT 'properties',  -- namespace的format类型
                                "IsPublic" BOOLEAN NOT NULL DEFAULT FALSE,  -- namespace是否为公共，使用 BOOLEAN 代替 bit(1)
                                "Comment" VARCHAR(64) NOT NULL DEFAULT '',  -- 注释
                                "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 1: deleted, 0: normal
                                "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                                "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                                "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                                "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "AppNamespace" IS '应用namespace定义';
COMMENT ON COLUMN "AppNamespace"."Id" IS '自增主键';
COMMENT ON COLUMN "AppNamespace"."Name" IS 'namespace名字，注意，需要全局唯一';
COMMENT ON COLUMN "AppNamespace"."AppId" IS 'app id';
COMMENT ON COLUMN "AppNamespace"."Format" IS 'namespace的format类型';
COMMENT ON COLUMN "AppNamespace"."IsPublic" IS 'namespace是否为公共';
COMMENT ON COLUMN "AppNamespace"."Comment" IS '注释';
COMMENT ON COLUMN "AppNamespace"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "AppNamespace"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "AppNamespace"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AppNamespace"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AppNamespace"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AppNamespace"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_AppId_Name_DeletedAt" ON "AppNamespace" ("AppId", "Name", "DeletedAt");

-- 创建普通索引
CREATE INDEX "Name_AppId" ON "AppNamespace" ("Name", "AppId");
CREATE INDEX "DataChange_LastTime_AppNamespace" ON "AppNamespace" ("DataChange_LastTime");

-- 删除表 Consumer
DROP TABLE IF EXISTS "Consumer";

-- 创建表 "Consumer"
CREATE TABLE "Consumer" (
                            "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                            "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',  -- AppID
                            "Name" VARCHAR(500) NOT NULL DEFAULT 'default',  -- 应用名
                            "OrgId" VARCHAR(32) NOT NULL DEFAULT 'default',  -- 部门Id
                            "OrgName" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 部门名字
                            "OwnerName" VARCHAR(500) NOT NULL DEFAULT 'default',  -- ownerName
                            "OwnerEmail" VARCHAR(500) NOT NULL DEFAULT 'default',  -- ownerEmail
                            "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 1: deleted, 0: normal，使用 BOOLEAN 代替 bit(1)
                            "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                            "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                            "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                            "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                            "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "Consumer" IS '开放API消费者';
COMMENT ON COLUMN "Consumer"."Id" IS '自增Id';
COMMENT ON COLUMN "Consumer"."AppId" IS 'AppID';
COMMENT ON COLUMN "Consumer"."Name" IS '应用名';
COMMENT ON COLUMN "Consumer"."OrgId" IS '部门Id';
COMMENT ON COLUMN "Consumer"."OrgName" IS '部门名字';
COMMENT ON COLUMN "Consumer"."OwnerName" IS 'ownerName';
COMMENT ON COLUMN "Consumer"."OwnerEmail" IS 'ownerEmail';
COMMENT ON COLUMN "Consumer"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Consumer"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Consumer"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Consumer"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Consumer"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Consumer"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_AppId_DeletedAt_Consumer" ON "Consumer" ("AppId", "DeletedAt");

-- 创建普通索引
CREATE INDEX "DataChange_LastTime_Consumer" ON "Consumer" ("DataChange_LastTime");

-- 删除表 ConsumerAudit
DROP TABLE IF EXISTS "ConsumerAudit";

-- 创建表 "ConsumerAudit"
CREATE TABLE "ConsumerAudit" (
                                 "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                                 "ConsumerId" INT NOT NULL,  -- ConsumerId
                                 "Uri" VARCHAR(1024) NOT NULL DEFAULT '',  -- 访问的Uri
                                 "Method" VARCHAR(16) NOT NULL DEFAULT '',  -- 访问的Method
                                 "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                 "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "ConsumerAudit" IS 'consumer审计表';
COMMENT ON COLUMN "ConsumerAudit"."Id" IS '自增Id';
COMMENT ON COLUMN "ConsumerAudit"."ConsumerId" IS 'Consumer Id';
COMMENT ON COLUMN "ConsumerAudit"."Uri" IS '访问的Uri';
COMMENT ON COLUMN "ConsumerAudit"."Method" IS '访问的Method';
COMMENT ON COLUMN "ConsumerAudit"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ConsumerAudit"."DataChange_LastTime" IS '最后修改时间';

-- 创建普通索引
CREATE INDEX "IX_DataChange_LastTime_ConsumerAudit" ON "ConsumerAudit" ("DataChange_LastTime");
CREATE INDEX "IX_ConsumerId" ON "ConsumerAudit" ("ConsumerId");

-- 删除表 ConsumerRole
DROP TABLE IF EXISTS "ConsumerRole";

-- 创建表 "ConsumerRole"
CREATE TABLE "ConsumerRole" (
                                "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                                "ConsumerId" INT NOT NULL,  -- Consumer Id
                                "RoleId" INT NOT NULL,  -- Role Id
                                "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 来代替 BIT 类型
                                "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                                "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                                "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                                "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "ConsumerRole" IS 'consumer和role的绑定表';
COMMENT ON COLUMN "ConsumerRole"."Id" IS '自增Id';
COMMENT ON COLUMN "ConsumerRole"."ConsumerId" IS 'Consumer Id';
COMMENT ON COLUMN "ConsumerRole"."RoleId" IS 'Role Id';
COMMENT ON COLUMN "ConsumerRole"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "ConsumerRole"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "ConsumerRole"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "ConsumerRole"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ConsumerRole"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "ConsumerRole"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_ConsumerId_RoleId_DeletedAt" ON "ConsumerRole" ("ConsumerId", "RoleId", "DeletedAt");

-- 创建普通索引
CREATE INDEX "IX_DataChange_LastTime_ConsumerRole" ON "ConsumerRole" ("DataChange_LastTime");
CREATE INDEX "IX_RoleId_ConsumerRole" ON "ConsumerRole" ("RoleId");

-- 删除表 ConsumerToken
DROP TABLE IF EXISTS "ConsumerToken";

-- 创建表 "ConsumerToken"
CREATE TABLE "ConsumerToken" (
                                 "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                                 "ConsumerId" INT,  -- ConsumerId
                                 "Token" VARCHAR(128) NOT NULL DEFAULT '',  -- token
                                 "Expires" TIMESTAMP NOT NULL DEFAULT '2099-01-01 00:00:00',  -- token失效时间，使用 TIMESTAMP 类型
                                 "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 来代替 BIT 类型
                                 "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                                 "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                                 "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                 "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                                 "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "ConsumerToken" IS 'consumer token表';
COMMENT ON COLUMN "ConsumerToken"."Id" IS '自增Id';
COMMENT ON COLUMN "ConsumerToken"."ConsumerId" IS 'ConsumerId';
COMMENT ON COLUMN "ConsumerToken"."Token" IS 'token';
COMMENT ON COLUMN "ConsumerToken"."Expires" IS 'token失效时间';
COMMENT ON COLUMN "ConsumerToken"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "ConsumerToken"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "ConsumerToken"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "ConsumerToken"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ConsumerToken"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "ConsumerToken"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_Token_DeletedAt" ON "ConsumerToken" ("Token", "DeletedAt");

-- 创建普通索引
CREATE INDEX "DataChange_LastTime_ConsumerToken" ON "ConsumerToken" ("DataChange_LastTime");

-- 删除表 Favorite
DROP TABLE IF EXISTS "Favorite";

-- 创建表 "Favorite"
CREATE TABLE "Favorite" (
                            "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                            "UserId" VARCHAR(32) NOT NULL DEFAULT 'default',  -- 收藏的用户
                            "AppId" VARCHAR(64) NOT NULL DEFAULT 'default',  -- AppID
                            "Position" INT NOT NULL DEFAULT 10000,  -- 收藏顺序
                            "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 BIT 类型
                            "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                            "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                            "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                            "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                            "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "Favorite" IS '应用收藏表';
COMMENT ON COLUMN "Favorite"."Id" IS '主键';
COMMENT ON COLUMN "Favorite"."UserId" IS '收藏的用户';
COMMENT ON COLUMN "Favorite"."AppId" IS 'AppID';
COMMENT ON COLUMN "Favorite"."Position" IS '收藏顺序';
COMMENT ON COLUMN "Favorite"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Favorite"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Favorite"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Favorite"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Favorite"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Favorite"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_UserId_AppId_DeletedAt" ON "Favorite" ("UserId", "AppId", "DeletedAt");

-- 创建普通索引
CREATE INDEX "AppId" ON "Favorite" ("AppId");
CREATE INDEX "DataChange_LastTime_Favorite" ON "Favorite" ("DataChange_LastTime");

-- 删除表 Permission
DROP TABLE IF EXISTS "Permission";

-- 创建表 "Permission"
CREATE TABLE "Permission" (
                              "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                              "PermissionType" VARCHAR(32) NOT NULL DEFAULT '',  -- 权限类型
                              "TargetId" VARCHAR(256) NOT NULL DEFAULT '',  -- 权限对象类型
                              "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 BIT 类型
                              "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                              "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                              "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                              "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                              "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "Permission" IS 'permission表';
COMMENT ON COLUMN "Permission"."Id" IS '自增Id';
COMMENT ON COLUMN "Permission"."PermissionType" IS '权限类型';
COMMENT ON COLUMN "Permission"."TargetId" IS '权限对象类型';
COMMENT ON COLUMN "Permission"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Permission"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Permission"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Permission"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Permission"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Permission"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_TargetId_PermissionType_DeletedAt" ON "Permission" ("TargetId", "PermissionType", "DeletedAt");

-- 创建普通索引
CREATE INDEX "IX_DataChange_LastTime_Permission" ON "Permission" ("DataChange_LastTime");

-- 删除表 Role
DROP TABLE IF EXISTS "Role";

-- 创建表 "Role"
CREATE TABLE "Role" (
                        "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                        "RoleName" VARCHAR(256) NOT NULL DEFAULT '',  -- 角色名
                        "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 BIT 类型
                        "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                        "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                        "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                        "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                        "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "Role" IS '角色表';
COMMENT ON COLUMN "Role"."Id" IS '自增Id';
COMMENT ON COLUMN "Role"."RoleName" IS 'Role name';
COMMENT ON COLUMN "Role"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "Role"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "Role"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "Role"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "Role"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "Role"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_RoleName_DeletedAt" ON "Role" ("RoleName", "DeletedAt");

-- 创建普通索引
CREATE INDEX "IX_DataChange_LastTime_Role" ON "Role" ("DataChange_LastTime");

-- 删除表 RolePermission
DROP TABLE IF EXISTS "RolePermission";

-- 创建表 "RolePermission"
CREATE TABLE "RolePermission" (
                                  "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                                  "RoleId" INT NOT NULL,  -- RoleId
                                  "PermissionId" INT NOT NULL,  -- PermissionId
                                  "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 BIT 类型
                                  "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                                  "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                                  "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                  "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                                  "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "RolePermission" IS '角色和权限的绑定表';
COMMENT ON COLUMN "RolePermission"."Id" IS '自增Id';
COMMENT ON COLUMN "RolePermission"."RoleId" IS 'Role Id';
COMMENT ON COLUMN "RolePermission"."PermissionId" IS 'Permission Id';
COMMENT ON COLUMN "RolePermission"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "RolePermission"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "RolePermission"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "RolePermission"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "RolePermission"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "RolePermission"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_RoleId_PermissionId_DeletedAt" ON "RolePermission" ("RoleId", "PermissionId", "DeletedAt");

-- 创建普通索引
CREATE INDEX "IX_DataChange_LastTime_RolePermission" ON "RolePermission" ("DataChange_LastTime");
CREATE INDEX "IX_PermissionId" ON "RolePermission" ("PermissionId");

-- 删除表 ServerConfig
DROP TABLE IF EXISTS "ServerConfig";

-- 创建表 "ServerConfig"
CREATE TABLE "ServerConfig" (
                                "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                                "Key" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 配置项Key
                                "Value" VARCHAR(2048) NOT NULL DEFAULT 'default',  -- 配置项值
                                "Comment" VARCHAR(1024) DEFAULT '',  -- 注释
                                "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 BIT 类型
                                "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                                "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                                "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                                "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "ServerConfig" IS '配置服务自身配置';
COMMENT ON COLUMN "ServerConfig"."Id" IS '自增Id';
COMMENT ON COLUMN "ServerConfig"."Key" IS '配置项Key';
COMMENT ON COLUMN "ServerConfig"."Value" IS '配置项值';
COMMENT ON COLUMN "ServerConfig"."Comment" IS '注释';
COMMENT ON COLUMN "ServerConfig"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "ServerConfig"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "ServerConfig"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "ServerConfig"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "ServerConfig"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "ServerConfig"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_Key_DeletedAt" ON "ServerConfig" ("Key", "DeletedAt");

-- 创建普通索引
CREATE INDEX "DataChange_LastTime_ServerConfig" ON "ServerConfig" ("DataChange_LastTime");

-- 删除表 UserRole
DROP TABLE IF EXISTS "UserRole";

-- 创建表 "UserRole"
CREATE TABLE "UserRole" (
                            "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                            "UserId" VARCHAR(128) DEFAULT '',  -- 用户身份标识
                            "RoleId" BIGINT DEFAULT NULL,  -- Role Id
                            "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 使用 BOOLEAN 代替 BIT 类型
                            "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳
                            "DataChange_CreatedBy" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 创建人邮箱前缀
                            "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                            "DataChange_LastModifiedBy" VARCHAR(64) DEFAULT '',  -- 最后修改人邮箱前缀
                            "DataChange_LastTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

-- 添加注释
COMMENT ON TABLE "UserRole" IS '用户和role的绑定表';
COMMENT ON COLUMN "UserRole"."Id" IS '自增Id';
COMMENT ON COLUMN "UserRole"."UserId" IS '用户身份标识';
COMMENT ON COLUMN "UserRole"."RoleId" IS 'Role Id';
COMMENT ON COLUMN "UserRole"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "UserRole"."DeletedAt" IS 'Delete timestamp based on milliseconds';
COMMENT ON COLUMN "UserRole"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "UserRole"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "UserRole"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "UserRole"."DataChange_LastTime" IS '最后修改时间';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_UserId_RoleId_DeletedAt" ON "UserRole" ("UserId", "RoleId", "DeletedAt");

-- 创建普通索引
CREATE INDEX "IX_DataChange_LastTime_UserRole" ON "UserRole" ("DataChange_LastTime");
CREATE INDEX "IX_RoleId_UserRole" ON "UserRole" ("RoleId");

-- 删除表 Users
DROP TABLE IF EXISTS "Users";

-- 创建表 "Users"
CREATE TABLE "Users" (
                         "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                         "Username" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 用户登录账户
                         "Password" VARCHAR(512) NOT NULL DEFAULT 'default',  -- 密码
                         "UserDisplayName" VARCHAR(512) NOT NULL DEFAULT 'default',  -- 用户名称
                         "Email" VARCHAR(64) NOT NULL DEFAULT 'default',  -- 邮箱地址
                         "Enabled" SMALLINT DEFAULT NULL  -- 是否有效，使用 SMALLINT 代替 TINYINT
);

-- 添加注释
COMMENT ON TABLE "Users" IS '用户表';
COMMENT ON COLUMN "Users"."Id" IS '自增Id';
COMMENT ON COLUMN "Users"."Username" IS '用户登录账户';
COMMENT ON COLUMN "Users"."Password" IS '密码';
COMMENT ON COLUMN "Users"."UserDisplayName" IS '用户名称';
COMMENT ON COLUMN "Users"."Email" IS '邮箱地址';
COMMENT ON COLUMN "Users"."Enabled" IS '是否有效';

-- 创建唯一索引
CREATE UNIQUE INDEX "UK_Username" ON "Users" ("Username");

-- 删除表 Authorities
DROP TABLE IF EXISTS "Authorities";

-- 创建表 "Authorities"
CREATE TABLE "Authorities" (
                               "Id" SERIAL PRIMARY KEY,  -- 使用 SERIAL 来表示自增字段
                               "Username" VARCHAR(64) NOT NULL,  -- 用户名
                               "Authority" VARCHAR(50) NOT NULL  -- 权限
);

-- 添加注释
COMMENT ON TABLE "Authorities" IS '权限表';
COMMENT ON COLUMN "Authorities"."Id" IS '自增Id';
COMMENT ON COLUMN "Authorities"."Username" IS '用户名';
COMMENT ON COLUMN "Authorities"."Authority" IS '权限';

DROP TABLE IF EXISTS SPRING_SESSION;

CREATE TABLE SPRING_SESSION (
                                PRIMARY_ID char(36) NOT NULL,
                                SESSION_ID char(36) NOT NULL,
                                CREATION_TIME bigint NOT NULL,
                                LAST_ACCESS_TIME bigint NOT NULL,
                                MAX_INACTIVE_INTERVAL int NOT NULL,
                                EXPIRY_TIME bigint NOT NULL,
                                PRINCIPAL_NAME varchar(100) DEFAULT NULL,
                                PRIMARY KEY (PRIMARY_ID)
);

CREATE UNIQUE INDEX SPRING_SESSION_IX1 ON SPRING_SESSION (SESSION_ID);
CREATE INDEX SPRING_SESSION_IX2 ON SPRING_SESSION (EXPIRY_TIME);
CREATE INDEX SPRING_SESSION_IX3 ON SPRING_SESSION (PRINCIPAL_NAME);

-- 添加注释
COMMENT ON TABLE SPRING_SESSION IS 'Spring Session 表';
COMMENT ON COLUMN SPRING_SESSION.PRIMARY_ID IS '主键ID';
COMMENT ON COLUMN SPRING_SESSION.SESSION_ID IS '会话ID';
COMMENT ON COLUMN SPRING_SESSION.CREATION_TIME IS '创建时间';
COMMENT ON COLUMN SPRING_SESSION.LAST_ACCESS_TIME IS '最后访问时间';
COMMENT ON COLUMN SPRING_SESSION.MAX_INACTIVE_INTERVAL IS '最大不活动时间间隔';
COMMENT ON COLUMN SPRING_SESSION.EXPIRY_TIME IS '过期时间';
COMMENT ON COLUMN SPRING_SESSION.PRINCIPAL_NAME IS '主体名称';

-- 删除表 SPRING_SESSION_ATTRIBUTES
DROP TABLE IF EXISTS SPRING_SESSION_ATTRIBUTES;

-- 创建表 SPRING_SESSION_ATTRIBUTES
CREATE TABLE SPRING_SESSION_ATTRIBUTES (
                                           SESSION_PRIMARY_ID CHAR(36) NOT NULL,  -- 会话主键ID
                                           ATTRIBUTE_NAME VARCHAR(200) NOT NULL,  -- 属性名称
                                           ATTRIBUTE_BYTES BYTEA NOT NULL,  -- 属性值 (使用 BYTEA 类型存储二进制数据)
                                           PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),  -- 联合主键
                                           CONSTRAINT SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_PRIMARY_ID) REFERENCES SPRING_SESSION (PRIMARY_ID) ON DELETE CASCADE  -- 外键约束
);

-- 添加注释
COMMENT ON TABLE SPRING_SESSION_ATTRIBUTES IS 'Spring Session 属性表';
COMMENT ON COLUMN SPRING_SESSION_ATTRIBUTES.SESSION_PRIMARY_ID IS '会话主键ID';
COMMENT ON COLUMN SPRING_SESSION_ATTRIBUTES.ATTRIBUTE_NAME IS '属性名称';
COMMENT ON COLUMN SPRING_SESSION_ATTRIBUTES.ATTRIBUTE_BYTES IS '属性值';

-- 删除表 AuditLog
DROP TABLE IF EXISTS "AuditLog";

-- 创建表 "AuditLog"
CREATE TABLE "AuditLog" (
                            "Id" SERIAL PRIMARY KEY,  -- 自增主键，PostgreSQL使用 SERIAL类型
                            "TraceId" VARCHAR(32) NOT NULL DEFAULT '',  -- 链路全局唯一ID
                            "SpanId" VARCHAR(32) NOT NULL DEFAULT '',  -- 跨度ID
                            "ParentSpanId" VARCHAR(32),  -- 父跨度ID
                            "FollowsFromSpanId" VARCHAR(32),  -- 上一个兄弟跨度ID
                            "Operator" VARCHAR(64) NOT NULL DEFAULT 'anonymous',  -- 操作人
                            "OpType" VARCHAR(50) NOT NULL DEFAULT 'default',  -- 操作类型
                            "OpName" VARCHAR(150) NOT NULL DEFAULT 'default',  -- 操作名称
                            "Description" VARCHAR(200),  -- 备注
                            "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 是否删除，PostgreSQL使用BOOLEAN类型
                            "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳（毫秒）
                            "DataChange_CreatedBy" VARCHAR(64),  -- 创建人邮箱前缀
                            "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                            "DataChange_LastModifiedBy" VARCHAR(64),  -- 最后修改人邮箱前缀
                            "DataChange_LastTime" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

CREATE INDEX "IX_TraceId_AuditLog" ON "AuditLog" ("TraceId");
CREATE INDEX "IX_OpName_AuditLog" ON "AuditLog" ("OpName");
CREATE INDEX "IX_DataChange_CreatedTime_AuditLog" ON "AuditLog" ("DataChange_CreatedTime");
CREATE INDEX "IX_Operator_AuditLog" ON "AuditLog" ("Operator");

-- 添加注释
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
COMMENT ON COLUMN "AuditLog"."DeletedAt" IS '删除时间戳，单位毫秒';
COMMENT ON COLUMN "AuditLog"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AuditLog"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AuditLog"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AuditLog"."DataChange_LastTime" IS '最后修改时间';

-- 删除表 AuditLogDataInfluence
DROP TABLE IF EXISTS "AuditLogDataInfluence";

-- 创建表 "AuditLogDataInfluence"
CREATE TABLE "AuditLogDataInfluence" (
                                         "Id" SERIAL PRIMARY KEY,  -- 自增主键，PostgreSQL使用 SERIAL类型
                                         "SpanId" CHAR(32) NOT NULL DEFAULT '',  -- 跨度ID
                                         "InfluenceEntityId" VARCHAR(50) NOT NULL DEFAULT '0',  -- 记录ID
                                         "InfluenceEntityName" VARCHAR(50) NOT NULL DEFAULT 'default',  -- 表名
                                         "FieldName" VARCHAR(50),  -- 字段名称
                                         "FieldOldValue" VARCHAR(500),  -- 字段旧值
                                         "FieldNewValue" VARCHAR(500),  -- 字段新值
                                         "IsDeleted" BOOLEAN NOT NULL DEFAULT FALSE,  -- 是否删除，PostgreSQL使用BOOLEAN类型
                                         "DeletedAt" BIGINT NOT NULL DEFAULT 0,  -- 删除时间戳（毫秒）
                                         "DataChange_CreatedBy" VARCHAR(64),  -- 创建人邮箱前缀
                                         "DataChange_CreatedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
                                         "DataChange_LastModifiedBy" VARCHAR(64),  -- 最后修改人邮箱前缀
                                         "DataChange_LastTime" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP  -- 最后修改时间
);

CREATE INDEX "IX_SpanId_AuditLogDataInfluence" ON "AuditLogDataInfluence" ("SpanId");
CREATE INDEX "IX_DataChange_CreatedTime_AuditLogDataInfluence" ON "AuditLogDataInfluence" ("DataChange_CreatedTime");
CREATE INDEX "IX_EntityId_AuditLogDataInfluence" ON "AuditLogDataInfluence" ("InfluenceEntityId");


-- 添加注释
COMMENT ON TABLE "AuditLogDataInfluence" IS '审计日志数据变动表';
COMMENT ON COLUMN "AuditLogDataInfluence"."Id" IS '主键';
COMMENT ON COLUMN "AuditLogDataInfluence"."SpanId" IS '跨度ID';
COMMENT ON COLUMN "AuditLogDataInfluence"."InfluenceEntityId" IS '记录ID';
COMMENT ON COLUMN "AuditLogDataInfluence"."InfluenceEntityName" IS '表名';
COMMENT ON COLUMN "AuditLogDataInfluence"."FieldName" IS '字段名称';
COMMENT ON COLUMN "AuditLogDataInfluence"."FieldOldValue" IS '字段旧值';
COMMENT ON COLUMN "AuditLogDataInfluence"."FieldNewValue" IS '字段新值';
COMMENT ON COLUMN "AuditLogDataInfluence"."IsDeleted" IS '1: deleted, 0: normal';
COMMENT ON COLUMN "AuditLogDataInfluence"."DeletedAt" IS '删除时间戳，单位毫秒';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_CreatedBy" IS '创建人邮箱前缀';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_CreatedTime" IS '创建时间';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_LastModifiedBy" IS '最后修改人邮箱前缀';
COMMENT ON COLUMN "AuditLogDataInfluence"."DataChange_LastTime" IS '最后修改时间';

-- Config
-- ------------------------------------------------------------
INSERT INTO "ServerConfig" ("Key", "Value", "Comment")
VALUES
    ('apollo.portal.envs', 'dev', '可支持的环境列表'),
    ('organizations', '[{"orgId":"TEST1","orgName":"样例部门1"},{"orgId":"TEST2","orgName":"样例部门2"}]', '部门列表'),
    ('superAdmin', 'apollo', 'Portal超级管理员'),
    ('api.readTimeout', '10000', 'http接口read timeout'),
    ('consumer.token.salt', 'someSalt', 'consumer token salt'),
    ('admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace'),
    ('configView.memberOnly.envs', 'pro', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔'),
    ('apollo.portal.meta.servers', '{}', '各环境Meta Service列表');


INSERT INTO "Users" ("Username", "Password", "UserDisplayName", "Email", "Enabled")
VALUES
    ('apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo', 'apollo@acme.com', 1);

INSERT INTO "Authorities" ("Username", "Authority") VALUES ('apollo', 'ROLE_user');

