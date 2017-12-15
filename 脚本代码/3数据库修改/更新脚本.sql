USE [WHJHAccountsDB]
GO

DELETE DBO.SystemStatusInfo WHERE StatusName = N'IOSNotStorePaySwitch'
DELETE DBO.SystemStatusInfo WHERE StatusName = N'JJGoldBuyProp'

-- 2017/11/16 ���ȫ���ƹ㷵������ 0����� 1����ʯ
-- INSERT INTO SystemStatusInfo
--   (StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID)
-- VALUES(N'SpreadReturnType', 0, N'ȫ���ƹ㷵������', N'�ƹ㷵������', N'��ֵ���ƹ㷵�����ͣ����ƹ㷵�������޿�������ʱ����Ч��0��ʾ��� 1��ʾ��ʯ', 99)
-- 2017/11/23 ���ȫ���ƹ㷵����ȡ�ż� 0�����ż� ����0���� ��Ҫ����ȡ�����ڶ��ٲ�����ȡ
-- INSERT INTO SystemStatusInfo
--   (StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID)
-- VALUES(N'SpreadReceiveBase', 0, N'ȫ���ƹ㷵����ȡ�ż�', N'�ƹ㷵������', N'��ֵ���ƹ㷵��������0�����ż� ����0���� ��Ҫ����ȡ�����ڶ��ٲ�����ȡ', 100)

-- 2017/12/13 �û������λ����Ϣ

ALTER TABLE [dbo].[AccountsInfo] ADD [PlaceName] NVARCHAR(33) NOT NULL DEFAULT(N'')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���һ�ε�¼����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AccountsInfo', @level2type=N'COLUMN',@level2name=N'PlaceName'
GO

USE [WHJHNativeWebDB]
GO

DELETE DBO.ConfigInfo WHERE ConfigKey = N'GameAndroidConfig'
DELETE DBO.ConfigInfo WHERE ConfigKey = N'GameIosConfig'

USE [WHJHTreasureDB]
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PresentScale'
GO
ALTER TABLE [dbo].[AppPayConfig] DROP CONSTRAINT [DF_AppPayConfig_PresentScale]
GO
ALTER TABLE [dbo].[AppPayConfig] DROP COLUMN [PresentScale]
GO
ALTER TABLE [dbo].[AppPayConfig] ADD [PresentDiamond] INT NOT NULL DEFAULT(0)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�׳�������ʯ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AppPayConfig', @level2type=N'COLUMN',@level2name=N'PresentDiamond'
GO


IF EXISTS (SELECT 1
FROM [DBO].SYSObjects
WHERE ID = OBJECT_ID(N'[dbo].[SpreadReturnConfig]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
  DROP TABLE [dbo].[SpreadReturnConfig]
END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SpreadReturnConfig]
(
  [ConfigID] [int] IDENTITY(1,1) NOT NULL,
  [SpreadLevel] [int] NOT NULL,
  [PresentScale] [decimal](18, 6) NOT NULL,
  [Nullity] [bit] NOT NULL,
  [UpdateTime] [datetime] NOT NULL,
  CONSTRAINT [PK_SpreadReturnConfig] PRIMARY KEY CLUSTERED
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[SpreadReturnConfig] ADD  CONSTRAINT [DF_SpreadReturnConfig_SpreadLevel]  DEFAULT ((0)) FOR [SpreadLevel]
GO

ALTER TABLE [dbo].[SpreadReturnConfig] ADD  CONSTRAINT [DF_SpreadReturnConfig_PresentScale]  DEFAULT ((0)) FOR [PresentScale]
GO

ALTER TABLE [dbo].[SpreadReturnConfig] ADD  CONSTRAINT [DF_SpreadReturnConfig_Nullity]  DEFAULT ((0)) FOR [Nullity]
GO

ALTER TABLE [dbo].[SpreadReturnConfig] ADD  CONSTRAINT [DF_SpreadReturnConfig_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���ñ�ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SpreadReturnConfig', @level2type=N'COLUMN',@level2name=N'ConfigID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�ƹ㼶��Ŀǰ��֧��3����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SpreadReturnConfig', @level2type=N'COLUMN',@level2name=N'SpreadLevel'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ�������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SpreadReturnConfig', @level2type=N'COLUMN',@level2name=N'PresentScale'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�Ƿ����ã�0�����á�1�����ã�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SpreadReturnConfig', @level2type=N'COLUMN',@level2name=N'Nullity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'����ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SpreadReturnConfig', @level2type=N'COLUMN',@level2name=N'UpdateTime'
GO

--
USE [WHJHRecordDB]
GO

IF EXISTS (SELECT 1
FROM [DBO].SYSObjects
WHERE ID = OBJECT_ID(N'[dbo].[RecordSpreadReturn]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
  DROP TABLE [dbo].[RecordSpreadReturn]
END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RecordSpreadReturn]
(
  [RecordID] [int] IDENTITY(1,1) NOT NULL,
  -- ��¼��ʶ
  [SourceUserID] [int] NOT NULL,
  -- ��ֵ����
  [TargetUserID] [int] NOT NULL,
  -- ��������
  [SourceDiamond] [int] NOT NULL,
  -- ��ֵ������ʯ
  [SpreadLevel] [int] NOT NULL,
  -- ���������ƹ㼶��
  [ReturnScale] [decimal](18, 6) NOT NULL,
  -- ��������
  [ReturnNum] [int] NOT NULL,
  -- ������ֵ ������ReturnType 0����� 1����ʯ��
  [ReturnType] [tinyint] NOT NULL,
  -- �������� 0����� 1����ʯ
  [CollectDate] [datetime] NOT NULL,
  -- ��¼����
  CONSTRAINT [PK_RecordSpreadReturn] PRIMARY KEY CLUSTERED
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_SourceUserID]  DEFAULT ((0)) FOR [SourceUserID]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_TargetUserID]  DEFAULT ((0)) FOR [TargetUserID]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_SourceDiamond]  DEFAULT ((0)) FOR [SourceDiamond]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_SpreadLevel]  DEFAULT ((0)) FOR [SpreadLevel]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_ReturnScale]  DEFAULT ((0)) FOR [ReturnScale]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_ReturnNum]  DEFAULT ((0)) FOR [ReturnNum]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_ReturnType]  DEFAULT ((0)) FOR [ReturnType]
GO
ALTER TABLE [dbo].[RecordSpreadReturn] ADD  CONSTRAINT [DF_RecordSpreadReturn_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'SourceUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'TargetUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ֵ������ʯ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'SourceDiamond'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'���������ƹ㼶��Ŀǰ��֧��3����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'SpreadLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'ReturnScale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'������ֵ ������ReturnType 0����� 1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'ReturnNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�������ͣ�0����ҡ�1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'ReturnType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturn', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO


IF EXISTS (SELECT 1
FROM [DBO].SYSObjects
WHERE ID = OBJECT_ID(N'[dbo].[RecordSpreadReturnReceive]') AND OBJECTPROPERTY(ID,'IsTable')=1 )
BEGIN
  DROP TABLE [dbo].[RecordSpreadReturnReceive]
END

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RecordSpreadReturnReceive]
(
  [RecordID] [int] IDENTITY(1,1) NOT NULL,
  -- ��¼��ʶ
  [UserID] [int] NOT NULL,
  -- �û���ʶ
  [ReceiveType] [tinyint] NOT NULL,
  -- ��ȡ���� 0����� 1����ʯ
  [ReceiveNum] [int] NOT NULL,
  -- ��ȡ��ֵ ������ReceiveType 0����� 1����ʯ��
  [ReceiveBefore] [bigint] NOT NULL,
  -- ��ȡǰ��ֵ������ReceiveType 0����� 1����ʯ��
  [ReceiveAddress] [nvarchar](15) NOT NULL,
  -- ��ȡ��ַ
  [CollectDate] [datetime] NOT NULL,
  -- ��¼����
  CONSTRAINT [PK_RecordSpreadReturnReceive] PRIMARY KEY CLUSTERED
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveNum]  DEFAULT ((0)) FOR [ReceiveNum]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveType]  DEFAULT ((0)) FOR [ReceiveType]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveBefore]  DEFAULT ((0)) FOR [ReceiveBefore]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_ReceiveAddress]  DEFAULT (N'') FOR [ReceiveBefore]
GO
ALTER TABLE [dbo].[RecordSpreadReturnReceive] ADD  CONSTRAINT [DF_RecordSpreadReturnReceive_CollectDate]  DEFAULT (getdate()) FOR [CollectDate]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼��ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'RecordID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'�û���ʶ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ���ͣ�0����ҡ�1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ��ֵ������ReceiveType 0����� 1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡǰ��ֵ������ReceiveType 0����� 1����ʯ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveBefore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��ȡ��ַ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'ReceiveAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'��¼ʱ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RecordSpreadReturnReceive', @level2type=N'COLUMN',@level2name=N'CollectDate'
GO
