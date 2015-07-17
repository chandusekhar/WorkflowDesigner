/*
Company: OptimaJet
Project: WorkflowEngine.NET Provider for MSSQL
Version: 1.5.0
File: DropPersistenceObjects.sql
*/

BEGIN TRANSACTION

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowProcessScheme')
BEGIN
	DROP TABLE [dbo].[WorkflowProcessScheme]
	PRINT 'WorkflowProcessScheme DROP TABLE'
END

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowProcessInstance')
BEGIN
	DROP TABLE [dbo].[WorkflowProcessInstance]
	PRINT 'WorkflowProcessInstance DROP DROP'
END

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowProcessInstancePersistence')
BEGIN
	DROP TABLE [dbo].[WorkflowProcessInstancePersistence]
	PRINT 'WorkflowProcessInstancePersistence DROP TABLE'
END

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowProcessTransitionHistory')
BEGIN
	DROP TABLE [dbo].[WorkflowProcessTransitionHistory]
	PRINT 'WorkflowProcessTransitionHistory DROP TABLE'
END

IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = N'tWorkflowProcessTransitionHistoryInsert')
BEGIN
	DROP TRIGGER [dbo].[tWorkflowProcessTransitionHistoryInsert]
	PRINT 'WorkflowProcessTransitionHistory DROP TRIGGER tWorkflowProcessTransitionHistoryInsert'
END

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowProcessInstanceStatus')
BEGIN
	DROP TABLE [dbo].[WorkflowProcessInstanceStatus]
	PRINT 'WorkflowProcessInstanceStatus DROP TABLE'
END

IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = N'spWorkflowProcessResetRunningStatus')
BEGIN
	DROP PROCEDURE [spWorkflowProcessResetRunningStatus]
	PRINT 'spWorkflowProcessResetRunningStatus DROP PROCEDURE'
END


IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowRuntime')
BEGIN
	DROP TABLE [dbo].[WorkflowRuntime]
	PRINT 'WorkflowRuntime DROP TABLE'
END

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowScheme')
BEGIN
	DROP TABLE [dbo].[WorkflowScheme]
	PRINT 'WorkflowScheme DROP TABLE'
END

IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = N'DropWorkflowProcess')
BEGIN
	DROP PROCEDURE [dbo].[DropWorkflowProcess] 
	PRINT 'DropWorkflowProcess DROP PROCEDURE'
END

IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = N'DropWorkflowProcesses')
BEGIN
	DROP PROCEDURE [dbo].[DropWorkflowProcesses] 
	PRINT 'DropWorkflowProcesses DROP PROCEDURE'

	DROP TYPE IdsTableType 
	PRINT 'IdsTableType DROP TYPE'
END

IF EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowInbox')
BEGIN
	DROP TABLE [dbo].[WorkflowInbox]
	PRINT 'WorkflowInbox DROP TABLE'
END

IF EXISTS (SELECT 1 FROM sys.procedures WHERE name = N'DropWorkflowInbox')
BEGIN
	DROP PROCEDURE [dbo].[DropWorkflowInbox]
	PRINT 'DropWorkflowInbox DROP PROCEDURE'
END

IF  EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowProcessTimer')
BEGIN
	DROP TABLE [dbo].[WorkflowProcessTimer]
	PRINT 'WorkflowProcessTimer DROP TABLE'
END

IF  EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'WorkflowGlobalParameter')
BEGIN
	DROP TABLE [dbo].[WorkflowGlobalParameter]
	PRINT 'WorkflowGlobalParameter DROP TABLE'
END

COMMIT TRANSACTION