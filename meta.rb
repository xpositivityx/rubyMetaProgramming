require 'nokogiri'

module Parser
	def parse_xml file
		@doc = Nokogiri::XML(File.open(file))
	end
end

class CIA96
	
	include Parser
	
	def initialize file
		@doc = parse_xml(file)
	end

	def method_missing method, *args
		country = @doc.xpath("//country[@name='#{method.capitalize}']")[0]
		if(country.nil?)
			super
		end
		if !args.empty?
			answer = country.attributes[*args[0]]
			if(answer.nil?)
				puts "Not a valid attribute"
				return
			end
		else
			answer = country.attributes['name']
		end

		puts answer
	
	end

end


c = CIA96.new('cia-1996.xml')

c.zambia('govrnment')