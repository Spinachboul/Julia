using Profile
using ProfileSVG

# Introduce a delay by performing some computational task
function time_consuming_task()
    x = 0
    for i in 1:1000000
        x += i
    end
    return x
end

# Function to profile the time_consuming_task
function profile_task()
    Profile.clear()
    Profile.init(delay = 0.5)  # Adjust delay as needed
    @profile time_consuming_task()  # Call the time-consuming task
    ProfileSVG.view()
end

profile_task()
