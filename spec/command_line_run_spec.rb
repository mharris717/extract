require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SheetDefinition" do
  let(:cl_run) do
    Extract::CommandLineRun.new(raw_options: raw_options)
  end

  describe "output as address" do
    let(:raw_options) do
      "--output C12 --PA 550".split(" ")
    end

    it 'result' do
      cl_run.result.should == 0.44
    end
  end

  describe "output as name" do
    let(:raw_options) do
      "--output SLG --PA 550".split(" ")
    end

    it 'result' do
      cl_run.result.should == 0.44
    end
  end


end