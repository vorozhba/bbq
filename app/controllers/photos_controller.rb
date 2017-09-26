class PhotosController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]
  before_action :set_new_photo, only: [:create]

  def create
    unless current_user.present?
      return redirect_to @event, alert: I18n.t('activerecord.controllers.photos.current_user_error')
    end

    @new_photo.user = current_user

    if  @new_photo.photo.url.present? && @new_photo.save
      notify_new_photo(@event, @new_photo)

      redirect_to @event, notice: I18n.t('activerecord.controllers.photos.created')
    else
      redirect_to @event, alert: I18n.t('activerecord.controllers.photos.error')
    end
  end

  def destroy
    message = {notice: I18n.t('activerecord.controllers.photos.destroyed')}

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = {alert: I18n.t('activerecord.controllers.photos.error')}
    end

    redirect_to @event, message
  end

  private
  # Так как фотография — вложенный ресурс, то в params[:event_id] рельсы
  # автоматически положает id события, которому принадлежит фотография
  # найденное событие будет лежать в переменной контроллера @event
  def set_event
    @event = Event.find(params[:event_id])
  end

  # Получаем фотографию из базы стандартным методом find
  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  # При создании новой фотографии мы получаем массив параметров photo
  # c единственным полем (оно тоже называется photo)
  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end

  def notify_new_photo(event, photo)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user.email]).uniq

    all_emails.each do |mail|
      EventMailer.photo(photo, event, mail).deliver_now
    end
  end

  def set_new_photo
    @new_photo = @event.photos.build(photo_params)
  end
end
