require "spec_helper"

include Rapidoc

describe Rapidoc::Config do

  it "config_dir return correct dir" do
    config_dir().should eql( ::Rails.root.to_s + '/config/rapidoc' )
  end

  it "config_dir return correct dir + file" do
    config_dir('file.yml').should eql( ::Rails.root.to_s + '/config/rapidoc/file.yml' )
  end

  it "controller_dir return correct dir" do
    controller_dir().should eql( ::Rails.root.to_s + '/app/controllers' )
  end

  it "controller_dir return correct dir + file" do
    controller_dir('file.rb').should eql( ::Rails.root.to_s + '/app/controllers/file.rb' )
  end

  it "gem_templates_dir return correct dir" do
    gem_templates_dir().should =~ /(.*)\/lib\/rapidoc\/templates/
  end

  it "gem_templates_dir return correct dir + file" do
    gem_templates_dir('template.hbs').should  =~ /(.*)\/templates\/template\.hbs/
  end

  context "check target_dir" do
    before do
      File.open("#{config_dir}/rapidoc.yml", 'w') { |file| file.write "route: \"vim\"" }
    end

    after do
      `rm -r #{ target_dir }`
    end

    it "target_dir return correct dir" do
      target_dir().should eql( target_dir )
    end

    it "target_dir return correct dir + file" do
      target_dir('file.html').should eql( target_dir + '/file.html' )
    end
  end

  context "when call target_dir" do
    context "when config file has a route" do
      before do
        File.open("#{config_dir}/rapidoc.yml", 'w') { |file| file.write "route: \"vim\"" }
      end

      after do
        `rm -r #{ target_dir }`
      end

      it "target_dir return correct route" do
        target_dir.should ==  ::Rails.root.to_s + "/vim"
      end
    end

    context "when config file hasn't a route" do
      before do
        File.open("#{config_dir}/rapidoc.yml", 'w') { |file| file.write "" }
      end

      after do
        `rm -r #{ target_dir }`
      end

      it "target_dir return incorrect route" do
        target_dir.should == ::Rails.root.to_s + "/rapidoc"
      end
    end
  end

end
