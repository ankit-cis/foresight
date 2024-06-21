module StatusesHelper
    def display_name(user)
        [user.forename, user.surname].reject(&:blank?).join(' ')
    end
end
