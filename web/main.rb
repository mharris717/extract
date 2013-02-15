require 'sinatra'
require 'haml'

load "/users/mharris717/code/orig/extract/lib/extract.rb"

helpers do
  def sheet
    file = "/users/mharris717/code/orig/extract/samples/div.xlsx"
    #$sheet ||= Extract::SheetDefinition.load(file,%w(B42))
    
    $sheet ||= Extract::SheetDefinition.load(file,%w(B38 B41 B51 B52))
  end
end

get "/" do
  @sheet = sheet
  
  if params[:input]
    params[:input].each do |cell,val|
      val = val.to_f if val.present?
      @sheet.sheet[cell] = val
    end
  end

  haml :index
end