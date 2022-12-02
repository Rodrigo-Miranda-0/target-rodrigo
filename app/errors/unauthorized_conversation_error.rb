class UnauthorizedConversationError < StandardError
  def message
    I18n.t('api.errors.invalid_conversation')
  end
end
