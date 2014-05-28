require 'spec_helper'
require "#{Rails.root}/lib/latin_to_integer.rb"

class Test
  include LatinToInteger
end

describe LatinToInteger do
  subject { Test.new }

  describe '#calcul' do
    describe 'letter values' do
      it 'M should have the value of 1000' do
        result = subject.latin_to_integer("M")
        result.should == 1000
      end

      it 'D should have the value of 500' do
        result = subject.latin_to_integer("D")
        result.should == 500
      end

      it 'C should have the value of 100' do
        result = subject.latin_to_integer("C")
        result.should == 100
      end

      it 'L should have the value of 50' do
        result = subject.latin_to_integer("L")
        result.should == 50
      end

      it 'X should have the value of 10' do
        result = subject.latin_to_integer("X")
        result.should == 10
      end

      it 'V should have the value of 5' do
        result = subject.latin_to_integer("V")
        result.should == 5
      end

      it 'I should have the value of 1' do
        result = subject.latin_to_integer("I")
        result.should == 1
      end
    end

    describe '9, 99, 999, 4999:' do
      it 'IX should have the value of 9' do
        result = subject.latin_to_integer("IX")
        result.should == 9
      end

      it 'XCIX should have the value of 99' do
        result = subject.latin_to_integer("XCIX")
        result.should == 99
      end

      it 'CMXCIX should have the value of 999' do
        result = subject.latin_to_integer("CMXCIX")
        result.should == 999
      end

      it 'MMMMCMXCIX should have the value of 4999' do
        result = subject.latin_to_integer("MMMMCMXCIX")
        result.should == 4999
      end
    end

    describe '2->10' do
      it 'II should have the value of 2' do
        result = subject.latin_to_integer("II")
        result.should == 2
      end

      it 'III should have the value of 3' do
        result = subject.latin_to_integer("III")
        result.should == 3
      end

      it 'IV should have the value of 4' do
        result = subject.latin_to_integer("IV")
        result.should == 4
      end

      it 'VI should have the value of 6' do
        result = subject.latin_to_integer("VI")
        result.should == 6
      end

      it 'VII should have the value of 7' do
        result = subject.latin_to_integer("VII")
        result.should == 7
      end

      it 'VIII should have the value of 8' do
        result = subject.latin_to_integer("VIII")
        result.should == 8
      end
    end

    describe 'correct combinations' do
      it 'CM should have the value of 900' do
        result = subject.latin_to_integer("CM")
        result.should == 900
      end

      it 'CD should have the value of 400' do
        result = subject.latin_to_integer("CD")
        result.should == 400
      end

      it 'XC should have the value of 90' do
        result = subject.latin_to_integer("XC")
        result.should == 90
      end

      it 'XL should have the value of 40' do
        result = subject.latin_to_integer("XL")
        result.should == 40
      end

      it 'MMM should have the value of 3000' do
        result = subject.latin_to_integer("MMM")
        result.should == 3000
      end

      it 'CCC should have the value of 300' do
        result = subject.latin_to_integer("CCC")
        result.should == 300
      end

      it 'XXX should have the value of 30' do
        result = subject.latin_to_integer("XXX")
        result.should == 30
      end

      it 'III should have the value of 3' do
        result = subject.latin_to_integer("III")
        result.should == 3
      end
    end
  end

  describe '#verify' do
    describe 'impossible combinations' do
      it "DM shouldn't be possible" do
        expect { subject.latin_to_integer("DM")}.to raise_error
      end

      it "LD shouldn't be possible" do
        expect { subject.latin_to_integer("LD")}.to raise_error
      end

      it "IC shouldn't be possible" do
        expect { subject.latin_to_integer("IC")}.to raise_error
      end

      it "XM shouldn't be possible" do
        expect { subject.latin_to_integer("XM")}.to raise_error
      end

      it "LV shouldn't be possible" do
        expect { subject.latin_to_integer("LV")}.to raise_error
      end

      it "IIIV shouldn't be possible" do
        expect { subject.latin_to_integer("IIIV")}.to raise_error
      end

      it "XXL shouldn't be possible" do
        expect { subject.latin_to_integer("XXL")}.to raise_error
      end

      it "XXXC shouldn't be possible" do
        expect { subject.latin_to_integer("XXXC")}.to raise_error
      end

      it "CCD shouldn't be possible" do
        expect { subject.latin_to_integer("CCD")}.to raise_error
      end

      it "CCCM shouldn't be possible" do
        expect { subject.latin_to_integer("CCCM")}.to raise_error
      end
    end

    describe 'too many letters' do
      it "IIII shouldn't be possible" do
        expect { subject.latin_to_integer("IIII")}.to raise_error
      end

      it "XXXXX shouldn't be possible" do
        expect { subject.latin_to_integer("XXXXX")}.to raise_error
      end

      it "CCCCCC shouldn't be possible" do
        expect { subject.latin_to_integer("CCCCCC")}.to raise_error
      end

      it "MMMMMMM shouldn't be possible" do
        expect { subject.latin_to_integer("MMMMMMM")}.to raise_error
      end

      it "DDD shouldn't be possible" do
        expect { subject.latin_to_integer("DDD")}.to raise_error
      end

      it "LLL shouldn't be possible" do
        expect { subject.latin_to_integer("LLL")}.to raise_error
      end

      it "VVV shouldn't be possible" do
        expect { subject.latin_to_integer("VVV")}.to raise_error
      end
    end
  end
end