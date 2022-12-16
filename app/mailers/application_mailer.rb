class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
  prepend_view_path "app/views/api/v1"

  def target_match(target)
    @target = target
    @user = target.user
    mail(to: @user.email, subject: I18n.t('mailer.match.subject')) if @user.email.present?
  end

  def new_message(user, message)
    @user = user
    @message = message
    mail(to: @user.email, subject: I18n.t('mailer.message.subject')) if @user.email.present?
  end
end
