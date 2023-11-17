/*----------------------------------------------------------------------------------------------------------------------
    Sınıf Çalışması: Aşağıdaki tabloları dbps23_schooldb veritabanında oluşturunuz ve soruları yanıtlayınız
    students
        - student_id
        - citizen_number
        - first_name
        - middle_name
        - last_name
        - birth_date
        - address
    lectures
        - lecture_code char(7)
        - name
        - credits
    grades
        - grade_id
        - description
        - value
    enrolls
        - enroll_id
        - student_id
        - lecture_code
        - grade_id

  Harf notları ve karşılık gelen değerler aşağıdaki gibi olabilir
    AA -> 4.0
    BA -> 3.5
    BB -> 3.0
    CB -> 2.5
    CC -> 2.0
    DC -> 1.5
    DD -> 1.0
    FF -> 0.0
    NA -> -1
    P  -> -1
  Sorular:
  - Parametresi ile aldığı ders kodu için öğrencilerin sayısını notlara göre gruplayarak getiren sorguya geri
  dönen fonksiyonu yazınız

  - Kredi toplamları parametresi ile aldığı değerden büyük olan öğrencilerin bilgilerine geri dönen fonksiyonu yazınız

  - Her bir dersi alan öğrencilerin sayısını veren sorguyu yazınız

  - Dersi, parametresi ile aldığı sayıdan fazla kez alan öğrencilerin kayıt olduğu dersleri gruplayan fonksiyonu yazınız

  - Dersi, parametresi ile aldığı sayıdan fazla kez alan öğrencilerin kayıt olduğu derslerin not ortalamasını getiren fonksiyonu
  yazınız

  - Bir dersin açılabilmesi için belli sayıda öğrencinin olması gerektiği durumda açılması için gereken minimum
    öğrenci sayısını parametre olarak alan ve açılabilen dersleri getiren fonksiyonu yazınız
-----------------------------------------------------------------------------------------------------------------------*/
