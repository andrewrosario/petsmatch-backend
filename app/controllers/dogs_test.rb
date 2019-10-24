dogless = User.all.select do |user| 
    if !user.pets.any? {|pet| pet.category.downcase === 'dog'}
        user
    end
end