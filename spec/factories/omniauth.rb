FactoryBot.define do
	# When calling auth_hash, use one of the traits listed below for a
	# github user trait.
	factory :auth_hash, class: OmniAuth::AuthHash do

		initialize_with do
			OmniAuth::AuthHash.new({
				provider: provider,
				uid: uid,
				info: {
					nickname: nickname,
					image: image
				},
				credentials: {
					token: token
				}
			})
		end

		trait :github do
			provider 'github'
			sequence(:uid)
			nickname 'poojajk'
			image 'https://avatars0.githubusercontent.com/u/42272976?v=4'
			sequence(:token)
		end

	end
end