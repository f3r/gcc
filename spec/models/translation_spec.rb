require 'spec_helper'

describe Translation do
  context "lookup" do
    before(:each) do
      I18n.locale = :en
      I18n.cache_store.clear
    end

    it "looks first on the .yml files" do
      # From cities/en.yml
      I18n.t('cities.singapore').should == 'Singapore'
    end

    it "database translations override .yml translations" do
      I18n.t('cities.singapore').should == 'Singapore'
      Translation.create(:key => 'cities.singapore', :locale => 'en', :value => 'Singapura')
      I18n.t('cities.singapore').should == 'Singapura'
    end

    it "caches translations" do
      I18n.t('cities.singapore').should == 'Singapore'

      Translation.any_instance.stub(:delete_cache).and_return(true) # Skip hooks
      trans = Translation.create!(:key => 'cities.singapore', :locale => 'en', :value => 'Singapura')
      I18n.t('cities.singapore').should == 'Singapore'
    end
  end

  context "load new translations from yaml" do
    before(:each) do
      @t = Translation.create!(:key => 'cities.singapore', :locale => 'en', :value => 'Singapore')
    end

    it "tracks user updated translations" do
      @t.should_not be_modified

      @t.value = 'Singland'
      @t.save!
      @t.reload

      @t.should be_modified
    end

    it "updates exiting translation when it wasnt modified by the user" do
      @t.should_not be_modified
      I18nUtil.create_translation('en', 'cities.singapore', nil, 'Singapura')

      @t.reload
      @t.value.should == 'Singapura'
      @t.should_not be_modified
    end


    it "doesn't update exiting translation when it was modified by the user" do
      @t.value = 'Singland'
      @t.save!
      @t.should be_modified

      I18nUtil.create_translation('en', 'cities.singapore', nil, 'Singapura')

      @t.reload
      @t.value.should == 'Singland'
      @t.should be_modified
    end
  end

  context "versioning" do
    before(:each) do
      @translation = Translation.create!(:key => 'cities.singapore', :locale => 'en', :value => 'Singapore')
    end

    it "stores a version" do
      #intially no version
      @translation.versions.count.should == 0
      @translation.value = "Singapore1"
      @translation.save
      @translation.versions.count.should == 1
    end

    it "check the version content" do
      old_val = @translation.value
      @translation.value = "Singapore1"
      @translation.save
      @translation.versions.first.value.should == old_val
    end

    it "deletion should remove the versions" do
      @translation.value = "Singapore1"
      @translation.save

      @translation.versions.count.should == 1

      @translation.destroy
      @translation.versions.first.should be_nil
    end
  end
  
  context "safeguard placeholders" do
    
    before(:each) do
      @translation = Translation.create!(:key => 'cities.singapore', :locale => 'en', :value => 'Singapore')
    end
    
    it "accept default placeholders" do
      @translation.value = "Singapore %{site_name}"
      @translation.save

      I18n.t('cities.singapore').should == "Singapore %{site_name}"
    end
    
    it "will not accept wrong placeholders" do
      @translation.value = "Singapore %{site_name1}"
      @translation.save
      
      I18n.t('cities.singapore').should == "Singapore"
    end
    
    it "will not accept wrong placeholders" do
      @translation.value = "Singapore %{link}"
      @translation.save
      
      I18n.t('cities.singapore').should == "Singapore"
    end
    
     it "accept correct placeholders" do
      @translation.value = "Singapore %{site_name} %{site_url}"
      @translation.save
      
      I18n.t('cities.singapore').should == "Singapore %{site_name} %{site_url}"
    end
  end
end
