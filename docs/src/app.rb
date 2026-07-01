require "js"

def with_error
  yield
rescue Exception => e
  RbWasmVdom::JSConsole.print_error(e)
end

# fetch json file from remote
# @param filename [String]
# @yield [Object]
def fetch_json(filename)
  JS.global.fetch(filename) do |response|
    response.json.then do |js_object|
      yield js_object
    end
  end
end

# @param js_object [JS::Object]
# @return [Array]
def to_ruby_array(js_object)
  array = []

  0.upto(js_object[:length].to_i - 1) do |index|
    array << js_object[index]
  end

  array
end

template = <<~HTML
  <div>
    <h3><a href="https://connpass.com/">connpass</a> ({{connpass_groups.length}} groups)</h3>
    <ul>
      <li #each="group in connpass_groups">
        <a href="{{ group.url }}">{{ group.name }}</a>
      </li>
    </ul>

    <h3><a href="https://www.doorkeeper.jp/">Doorkeeper</a> ({{doorkeeper_groups.length}} groups)</h3>
    <ul>
      <li #each="group in doorkeeper_groups">
        <a href="{{ group.url }}">{{ group.name }}</a>
      </li>
    </ul>  
  </div>
HTML

state = {
  connpass_groups: [],
  doorkeeper_groups: [],
}

fetch_json("config/connpass.json") do |data|
  with_error do
    groups = to_ruby_array(data.groups)
    groups.each do |group|
      group.url = "https://#{group.id}.connpass.com/"
    end
    state[:connpass_groups] = groups.sort{ |repo1, repo2| repo1.name.upcase <=> repo2.name.upcase }
  end
end

fetch_json("config/doorkeeper.json") do |data|
  with_error do
    groups = to_ruby_array(data.groups)
    groups.each do |group|
      group.url = "https://#{group.id}.doorkeeper.jp/"
    end
    state[:doorkeeper_groups] = groups.sort{ |repo1, repo2| repo1.name.upcase <=> repo2.name.upcase }
  end
end

# Initialize and mount the application
RbWasmVdom.create_app("#app", template: template, state: state)
