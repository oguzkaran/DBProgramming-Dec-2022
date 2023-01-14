/*----------------------------------------------------------------------------------------------------------------------
    conmcat_ws fonlsiyonu. Bu fonksiyon SQL Server 2017 ile birlikte eklenmiştir
-----------------------------------------------------------------------------------------------------------------------*/
declare @name nvarchar(100) = 'Oğuz Karan'
declare @email nvarchar(100) = 'oguzkaran@csystem.org'
declare @phone varchar(14) = '00905325158012'
declare  @info nvarchar(256)

set @info = concat_ws(':', @name, @email, @phone)

select @info