class EmailsController < ApplicationController
    def index
        @emails = Email.all
    end

    def create
        @email = Email.create(object: Faker::Lorem.sentence, body: Faker::Lorem.paragraphs(number: 3).join("\n"))
        
        render turbo_stream: [
            turbo_stream.prepend("new_message", partial: "messages", locals: { message: @email })
                    ]
    end
          
end