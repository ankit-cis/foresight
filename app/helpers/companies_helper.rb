module CompaniesHelper
    def user_email_disabled?(company, accept_terms)
        if accept_terms.present?
            accept_terms
        elsif company.setting.present?
            company.setting.disable_user_emails == false ? "1" : "0"
        else
            "1"
        end
    end
end
