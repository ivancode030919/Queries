USE [InventoryDB]
GO
/****** Object:  StoredProcedure [dbo].[loadConsolidateInventory4]    Script Date: 3/26/2024 11:41:19 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[loadConsolidateInventory4]

		 @igoodid varchar(250)
		,@vgooddes varchar(250)
		,@varea varchar(250)
		,@vbatches varchar(250)
		,@vlocation varchar(250)
	
AS
BEGIN

	SET NOCOUNT ON;
SELECT top 200
'' as dummy,
  T0.goodId,
  t1.goodDes,
  t2.area,
  t3.batchName,
  t4.name,
  SUM(T0.qty)
FROM tblProducts t0
INNER JOIN tblGoods t1 ON t1.id = t0.goodId
INNER JOIN tblAreas t2 ON t2.id = t0.areaId
INNER JOIN tblBatches t3 ON t3.id = t0.batchId
INNER JOIN tblLocations t4 ON t4.id = t0.locationId
WHERE(t0.goodId =  @igoodid or @igoodid = '')
  AND (t1.goodDes LIKE @vgooddes or @vgooddes='' )
  AND (t2.area = @varea or @varea='')
  AND (t4.name = @vlocation or @vlocation='')
  AND (t3.batchName LIKE @vbatches or @vbatches='')
GROUP BY T0.goodId, t1.goodDes, t2.area, t3.batchName, t4.name
HAVING SUM(t0.qty) > 0
ORDER BY t0.goodId ASC;

END
