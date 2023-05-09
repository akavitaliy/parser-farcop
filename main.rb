require 'mechanize'
require_relative 'links.rb'
require_relative 'file_save.rb'
require_relative 'write.rb'

link_save

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'

file = File.open("link_list.txt")

def table(target)
    table = target.at(".towbar-item-properties").search("dl.towbar-item-properties__item")
    arr = []
    arr2 = []
    table.each do |row|
        arr << row.text.strip
    end    
    arr.each {|item| arr2 << item.strip.split(':')}
    return arr2.to_h
end 


x = 0

file.each do |link|
    page = agent.get(link)
    block = page.search('.towbar-item-panel')
    block.each do |item|
        puts x += 1
        puts @brand = page.xpath("/html/body/section/div[2]/div[1]/div[2]/a/span").text.gsub('Фаркопы для', '').strip
        puts 'Модель: ' + @model = page.at("h4.towbars-page-title").text.gsub('Фаркопы для', '')
        puts 'Название: ' + @name = item.at("span.towbar-item-title__brand").text.strip
        puts 'Год:' + @year = item.at("span.towbar-item-title__year").text.gsub('Год выпуска:', '')
        puts 'Производитель: ' + @producer = 'АвтоС'
        puts 'Артикул: ' + @article = page.at("span.towbar-item-title__art").text.gsub('Артикул:', '')
        puts 'Алиас: ' + @alias = page.at("span.towbar-item-title__art").text.gsub('Артикул:', '')
        puts 'Вид товара: ' + @product = 'Фаркоп'              
        puts 'Тип крюка: ' + @hook = "#{table(item)['Снятие шара'].strip == 'Да' ? 'съёмный шар' : 'не съёмный шар'}"
        puts 'Масса нагрузки: ' + @mass = "#{table(item)['Масса груза (кг.)'].strip}/#{table(block)['Максимальная нагрузка на шар (кг.)'].strip}"
        puts 'Вес: ' + @weight = ' '
        puts 'Вырез бампера: ' + @bumpers = "#{table(item)['Подрезка бампера'].strip}"
        puts 'Электрика: ' + @electrica = 'В комплект поставки не входит'
        puts 'Описание: ' + @description = "Фаркоп #{@name}, #{@hook}. Устанавливается #{table(block)['Снятие бампера'].strip == 'Да' ? 'со снятием' : 'без снятия' } бампера."
        puts 'Цена: ' + @price = item.search(".towbar-item-price").any? ? item.at(".towbar-item-price").text.gsub('г', '').strip : '-'
        puts page.uri.to_s
        puts '=' * 20      
        
        writer_file(page.uri.to_s)
        file_save(item, @name, agent, x)
    end
end
