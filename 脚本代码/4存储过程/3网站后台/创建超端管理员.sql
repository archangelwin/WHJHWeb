----------------------------------------------------------------------
-- ʱ�䣺2015-10-10
-- ��;����̨����Ա��Ӵ����û�
----------------------------------------------------------------------
USE WHJHAccountsDB
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_AddSuperUser]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_AddSuperUser]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_AddSuperUser]
(
	@strAccounts			NVARCHAR(32),			--�û���
	@strLogonPass    	NVARCHAR(32),			-- ��¼����

	@strErrorDescribe NVARCHAR(127) OUTPUT		--�����Ϣ
)

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

DECLARE @UserID INT  -- �û���ʶ

BEGIN
	-- ���˹���Ա��Ϣ
	INSERT INTO [dbo].[AccountsInfo]
      ([Accounts],[NickName],[RegAccounts],[LogonPass],[InsurePass],[UserRight],[MasterRight],[ServiceRight],[MasterOrder]
		  ,[LastLogonIP],[LastLogonDate],[RegisterIP],[RegisterDate],[RegisterOrigin])
  VALUES
      (@strAccounts,@strAccounts,@strAccounts,@strLogonPass,@strLogonPass,536870912,184549632,0,9,
      N'',GETDATE(),N'',GETDATE(),0)

	SELECT @UserID = SCOPE_IDENTITY()

	-- �����û�
	IF @@ERROR=0
	BEGIN
		SET @strErrorDescribe=N'��ϲ�������˹���Ա�����ɹ���'
		RETURN 0
	END
	ELSE
	BEGIN
		SET @strErrorDescribe=N'��Ǹ�����˹���Ա����ʧ�ܡ�'
		RETURN 2003
	END
END
GO
