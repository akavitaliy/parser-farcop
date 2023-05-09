

def file_save(page, title, agent, x)
    images = page.at('.towbar-item-slider.fl-0-0-auto').search('.item-foto-thumbs__item img')
    
    images.each_with_index do |img, index|              
      agent.get(img['src']).save "img/#{x}#{title}/image_#{index}.jpg"
    end   

    if page.search('.doc-link').any?
        docs = page.at('.doc-link')['href']
        agent.get(docs).save "img/#{x}#{title}/паспорт.doc" 
    end
end