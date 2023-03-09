class EmailsController < ApplicationController
    def index
        @emails = Email.order(created_at: :desc)
    end

    def create
        @email = Email.create(object: Faker::Lorem.sentence, body: Faker::Lorem.paragraphs(number: 3).join("\n"))
        
        render turbo_stream: [
            turbo_stream.prepend("new_message", partial: "messages", locals: { message: @email })
                    ]
    end

    def show
        @email = Email.find(params[:id])
    end

    def destroy
        @email = Email.find(params[:id])
        @email.destroy

        respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.remove(@email) }
            format.html         { redirect_to emails_path }
        end
    end
          
end