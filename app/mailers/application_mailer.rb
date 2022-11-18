class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  prepend_view_path "app/views/api/v1"

  def target_match(target)
    @target = target
    @user = target.user
    mail(to: @user.email, subject: I18n.t('mailer.match.subject'))
  end
end
