require 'sinatra'
require 'haml'



load "/users/mharris717/code/orig/extract/lib/extract.rb"

f = File.expand_path(File.dirname(__FILE__)) + "/mongoid.yml"
Mongoid.load! f,'development'

helpers do
  def sheetd
    file = "/users/mharris717/code/orig/extract/samples/baseball.xlsx"
    #$sheet ||= Extract::SheetDefinition.load(file,%w(B42))
    
    #$sheet ||= Extract::SheetDefinition.load(file,%w(B38 B41 B51 B52))

    $sheet ||= Extract::SheetDefinition.load(file,%w(C10 C11 C12))
  end
end

get "/" do
  @sheet = sheet
  sheet.sheet.clear_cache!
  
  if params[:input]
    params[:input].each do |cell,val|
      val = val.to_f if val.present?
      @sheet.sheet[cell] = val
    end
  end

  haml :index
end

get "/upload" do
  haml :upload
end

post "/upload" do
  file = params['sheet'][:filename]
  puts params.inspect


  str = params['sheet'][:tempfile].read
  File.create("file.xlsx",str)

  cells = (params['output_cells'] || '').split(" ")

  sheet_def = Extract::SheetDefinition.load("file.xlsx",cells)
  sheet_def.save!

  haml :upload
end

get "/sheet/:id" do
  @sheet = Extract::Persist::Sheet.find(params[:id]).sheet_def
  haml :index
end