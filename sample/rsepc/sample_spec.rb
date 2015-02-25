describe Sample do
 
  cs_spec_for '#hello String -> String' do 
    sample.hello('Minion').should == 'Say Hello to Minion'
    sample.hello('Roberto').should == 'Say Hello to Roberto'
    sample.hello('Roland').should == 'Say Hello to Roland'
  end

  cs_spec_for '#sum Fixnum, Fixnum -> Fixnum' do
    sample.sum(1, 1).should == 2
    sample.sum(1, 2).should == 3
    sample.sum(2, 2).should == 4
  end

  cs_spec_for '#rule_of_three Float, Float, Float -> Float' do
    sample.rule_of_three(1.0, 1.0, 2.0).should == 2.0
    sample.rule_of_three(2.0, 4.0, 3.0).should == 6.0
    sample.rule_of_three(10.0, 2.0, 3.0).should == 0.6
  end

end
