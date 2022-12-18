import requests

# Set up the API endpoint and headers
api_endpoint = "https://api.openai.com/v1/chat"
headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer YOUR_API_KEY"
}

# Set up the model and prompt
model = "chatbot"
prompt = "What do you know about graphic design?"

# Create a list of index words
index_words = [
    "Adobe Creative Suite",
    "Art direction",
    "Branding",
    "Color theory",
    "Composition",
    "Conceptualization",
    "Creative brief",
    "Creative process",
    "Design elements",
    "Design software",
    "Design theory",
]

# Loop through the list of index words
for word in index_words:
    # Set up the request payload
    payload = {
        "model": model,
        "prompt": f"{prompt} {word}",
        "max_tokens": 256
    }

    # Make the request to the API
    response = requests.post(api_endpoint, json=payload, headers=headers)

    # Print the response
    print(response.json())
