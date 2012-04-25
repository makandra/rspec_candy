require 'spec_helper'

describe RSpecCandy::Helpers::ItShouldActLike do

  describe 'RSpec example group' do

    describe '#it_should_act_like' do

      it 'should scope the reused examples so definitions of #let and #subject do not bleed into the calling example group'

      it 'should allow to parametrize the reused example group by calling it with a hash, whose keys will become #let variables'

      it 'should allow to parametrize the reused example group by calling it with a block, which will become a #let variable called "block"'

      it 'should somehow deprecate itself in favor of the #it_should_behave_like from RSpec 2, which has arguments and blocks'
      
    end

  end

end
