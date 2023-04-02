/*----------------------------------------------------------------------------------------------------------------------
    Sınıf Çalışması: Basit bir çoktan seçmeki yarışmaya ilişkin aşağıdaki veritabanını oluşturunuz ve aşağıdaki soruları
    yanıtlayınız

    levels:
        level_id
        description
    questions:
        question_id
        description
        level_id
        answer_index
    options
        option_id
        description
        question_id

    Dikkat edilirse tüm soruların değişken sayıda seçenekleri olacaktır.
    Sorular:
    1. Her çalıştırıldığında herhangi bir seviyeden rasgele bir sorunun id'sini output olarak veren sp_get_random_question_id
    SP'sini yazınız

    2. TODO:Bir önceki SP'yi tablo döndüren fonksiyon olarak yazınız. Soruya ilişkin önemli bilgileri döndürünüz

    3. Her çalıştırıldığında parametresi ile aldığı seviye bilgisinden rasgele bir sorunun id'sini output olarak veren
    sp_get_random_question_id_by_level_id SP'sini yazınız

    4. TODO: Bir önceki SP'yi tablo döndüren fonksiyon olarak yazınız. Soruya ilişkin önemli bilgileri döndürünüz
-----------------------------------------------------------------------------------------------------------------------*/
create database competitionappdb

use competitionappdb

create table levels (
    level_id int primary key identity(1, 1),
    description nvarchar(100)
)

insert into levels (description)
values
('Seviye 1'), ('Seviye 2'), ('Seviye 3'), ('Seviye 4'), ('Seviye 5'),
('Seviye 6'), ('Seviye 7'), ('Seviye 8'), ('Seviye 9'), ('Seviye 10')

create table questions (
    question_id int primary key identity(1, 1),
    description nvarchar(max) not null,
    level_id int foreign key references levels(level_id) not null,
    answer_index int not null
)

create table options (
    option_id int primary key identity(1, 1),
    description nvarchar(max) not null,
    question_id int foreign key references questions(question_id),
)

create view v_get_random
as
select rand() as random

drop procedure sp_get_random_question_id

create procedure sp_get_random_question_id(@question_id int output, @answer_index int output, @status bit output)
as
begin
    -- TODO: Transaction safe hale getiriniz
    declare crs_questions cursor scroll for select question_id from questions
    open crs_questions

    declare @bound int = (select count(*) from questions) + 1
    declare @min int = 1
    declare @index int = floor(rand() * (@bound - @min) + @min)

    fetch absolute @index from crs_questions into @question_id

    if @@fetch_status = 0
        set @answer_index = (select answer_index from questions where question_id = @question_id)

    if @@fetch_status = 0
        set @status = 1
    else
        set @status = 0

    close crs_questions
    deallocate crs_questions
end


create procedure sp_get_random_question_id_by_level_id(@level_id int, @question_id int output, @answer_index int output, @status bit output)
as
begin
    -- TODO: Transaction safe hale getiriniz
    declare crs_questions cursor scroll for select question_id from questions where level_id = @level_id
    open crs_questions

    declare @bound int = (select count(*) from questions where level_id = @level_id) + 1
    declare @min int = 1
    declare @index int = floor(rand() * (@bound - @min) + @min)

    fetch absolute @index from crs_questions into @question_id

    if @@fetch_status = 0
        set @answer_index = (select answer_index from questions where question_id = @question_id)

    if @@fetch_status = 0
        set @status = 1
    else
        set @status = 0

    close crs_questions
    deallocate crs_questions
end


declare @status bit
declare @question_id int
declare @answer_index int

exec sp_get_random_question_id @question_id output, @answer_index output, @status output

if @status = 1
    select * from questions q inner join options o on q.question_id = o.question_id where o.question_id = @question_id
else
    select 'No question yet'

------------------------------------------------------------------------------------------------------------------------

declare @status bit
declare @question_id int
declare @answer_index int

exec sp_get_random_question_id_by_level_id 1, @question_id output, @answer_index output, @status output

if @status = 1
    select * from questions q inner join options o on q.question_id = o.question_id where o.question_id = @question_id
else
    select 'No question yet'

