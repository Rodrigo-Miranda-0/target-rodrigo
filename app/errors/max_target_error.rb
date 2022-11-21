class MaxTargetError < StandardError
  def message
    I18n.t('api.errors.max_targets')
  end
end
