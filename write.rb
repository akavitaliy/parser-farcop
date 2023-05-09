require 'spreadsheet'


row_1 = ['Название', 'Марка авто', 'Модель авто', 'Год выпуска', 'Производитель', 'Артикул', 'Алиас', 'Вид товара', 'Тип крюка', 'Масса нагрузки (Тяговая/на шар), кг', 'Вес ТСУ , кг', 'Вырез бампера', 'Электрика', 'Описание', 'Инструкции/Сертификаты', 'Цена, руб', 'Ссылка' ]    
@new_book = Spreadsheet::Workbook.new  
@new_book.create_worksheet :name => 'АвтоС'
@new_book.worksheet(0).insert_row(0, row_1)

def writer_file(link)
    row_2 = [@name, @brand, @model, @year, @producer, @article, @alias, @product, @hook, @mass, @weight, @bumpers, @electrica, @description, @insructions, @price, link ]
    
    @new_book.worksheet(0).insert_row(1, row_2)          
   
    @new_book.write('АвтоС.xls')
end