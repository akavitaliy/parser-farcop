

def link_save
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'

    target_link = 'https://avtos.su/sitemap/'

    page = agent.get(target_link)

    links = page.at('ul.map-level-1').search('.map-level-2 a')

    x = 0

    links.each do |link|
        puts x += 1
        target_link = 'https://avtos.su' + link['href']
        File.write("link_list.txt", "#{target_link}\n", mode: 'a')
    end
end