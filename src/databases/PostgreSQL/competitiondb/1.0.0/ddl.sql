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
create database competitionappdb;

create table levels (
    level_id serial primary key,
    description varchar(100)
);

insert into levels (description)
values
('Seviye 1'), ('Seviye 2'), ('Seviye 3'), ('Seviye 4'), ('Seviye 5'),
('Seviye 6'), ('Seviye 7'), ('Seviye 8'), ('Seviye 9'), ('Seviye 10')

create table questions (
    question_id serial primary key,
    description varchar(1024) not null,
    level_id int references levels(level_id) not null,
    answer_index int not null
)

create table options (
    option_id serial primary key,
    description varchar(512) not null,
    question_id int references questions(question_id)
)




