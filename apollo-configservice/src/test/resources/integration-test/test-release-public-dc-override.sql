--
-- Copyright 2022 Apollo Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
INSERT INTO "Release" (id, ReleaseKey, Name, Comment, AppId, ClusterName, NamespaceName, Configurations)
 VALUES (995, 'TEST-RELEASE-KEY6', 'INTEGRATION-TEST-DEFAULT-OVERRIDE-PUBLIC-DC','First Release','someAppId', 'someDC', 'somePublicNamespace', '{"k1":"override-someDC-v1"}');
