class ConversationPostBccRecipient
  include Mongoid::Document
  include Mongoid::Timestamps
   
  field :email, :type => String
  
  def self.admin_fields
    {
      :email => :email,
      :account_id => :lookup,
      :conversation_post_bcc_id => :lookup
    }
  end  
  
  belongs_to :conversation_post, index: true
  belongs_to :conversation_post_bcc, index: true
  belongs_to :account, index: true
  
  validates_presence_of :conversation_post_bcc, :conversation_post, :account, :email
  
  before_validation do
    self.conversation_post = self.conversation_post_bcc.conversation_post if self.conversation_post_bcc
    self.email = self.account.email if !self.email
  end
            
end