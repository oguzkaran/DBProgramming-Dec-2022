/*----------------------------------------------------------------------------------------------------------------------
    Sınıf Çalışması: Parametresi ile aldığı bir yazının ilk karakterinin aynı kalması kloşuluyla diğer karakterlerini 
    ikinci parametresi ile aldığı karakter olacak şekilde yeni bir yazı döndüren hide_text_right isimli fonksiyonu yazınız.
    Foksiyonu test etmek için aşağıdaki gibi bir tablo yaratıp sorgu yapabilirsiniz
    students:
        - student_id
        - citizen_id
        - first_name
        - last_name

    Sorgu için tablo döndüren bir fonksiyon yazınız
-----------------------------------------------------------------------------------------------------------------------*/
create function hide_text_right(@text nvarchar(max), @ch char(1), @n int)
returns nvarchar(max)
as
begin
    return left(@text, @n) + replicate(@ch, len(@text) - @n)
end

go

create table students (
    student_id int primary key identity(1, 1),
    citizen_id char(36) unique not null,
    first_name nvarchar(100) not null,
    last_name  nvarchar(100) not null
)

go 

create function get_student_hidden_information(@student_id int)
returns table
as
return 
(
    select student_id, 
    dbo.hide_text_right(citizen_id, '*', 1) as citizen_id,
    dbo.hide_text_right(first_name, '*', 1) + ' ' + dbo.hide_text_right(last_name, '*', 1) as full_name
    from students__ where student_id = @student_id
)

go


select * from dbo.get_student_hidden_information(10)

