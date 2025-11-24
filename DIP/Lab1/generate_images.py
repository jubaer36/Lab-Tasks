import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

# Ensure output directory exists
if not os.path.exists('report_images'):
    os.makedirs('report_images')

# Load image
img_path = 'cat.jpg'
if not os.path.exists(img_path):
    print(f"Error: {img_path} not found.")
    exit(1)

# Read as color (BGR)
cat_img = cv2.imread(img_path)
# Read as grayscale
gray_img = cv2.cvtColor(cat_img, cv2.COLOR_BGR2GRAY)

# Save original images for report
cv2.imwrite('report_images/original_color.png', cat_img)
cv2.imwrite('report_images/original_gray.png', gray_img)

# Task 1: Grayscale Histogram
def my_histogram(image, title="Image Histogram", filename="task1_hist.png"):
    if len(image.shape) == 3:
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    
    hist, bins = np.histogram(image.flatten(), 256, [0, 256])
    
    plt.figure(figsize=(6, 4))
    plt.title(title)
    plt.xlabel("Pixel Value")
    plt.ylabel("Frequency")
    plt.bar(range(256), hist, width=1, color='black')
    plt.xlim([0, 255])
    plt.grid(alpha=0.3)
    plt.savefig(f'report_images/{filename}')
    plt.close()

my_histogram(gray_img, "Grayscale Histogram", "task1_hist.png")

# Task 2: Color Channels
def channel_show(color_image):
    b, g, r = cv2.split(color_image)
    zeros = np.zeros_like(b)
    
    blue_img  = cv2.merge([b, zeros, zeros])
    green_img = cv2.merge([zeros, g, zeros])
    red_img   = cv2.merge([zeros, zeros, r])
    
    # Create a combined plot for the report
    plt.figure(figsize=(12, 4))
    plt.subplot(1, 3, 1); plt.imshow(cv2.cvtColor(red_img, cv2.COLOR_BGR2RGB)); plt.title('Red Channel'); plt.axis('off')
    plt.subplot(1, 3, 2); plt.imshow(cv2.cvtColor(green_img, cv2.COLOR_BGR2RGB)); plt.title('Green Channel'); plt.axis('off')
    plt.subplot(1, 3, 3); plt.imshow(cv2.cvtColor(blue_img, cv2.COLOR_BGR2RGB)); plt.title('Blue Channel'); plt.axis('off')
    plt.tight_layout()
    plt.savefig('report_images/task2_combined.png')
    plt.close()
    
    return b, g, r

b, g, r = channel_show(cat_img)

# Task 3: Color Histograms
def color_histogram(color_image):
    b, g, r = cv2.split(color_image)
    
    plt.figure(figsize=(12, 4))
    
    plt.subplot(1, 3, 1)
    hist_r, _ = np.histogram(r.flatten(), 256, [0, 256])
    plt.bar(range(256), hist_r, color='red')
    plt.title("Red Channel Histogram")
    
    plt.subplot(1, 3, 2)
    hist_g, _ = np.histogram(g.flatten(), 256, [0, 256])
    plt.bar(range(256), hist_g, color='green')
    plt.title("Green Channel Histogram")
    
    plt.subplot(1, 3, 3)
    hist_b, _ = np.histogram(b.flatten(), 256, [0, 256])
    plt.bar(range(256), hist_b, color='blue')
    plt.title("Blue Channel Histogram")
    
    plt.tight_layout()
    plt.savefig('report_images/task3_histograms.png')
    plt.close()

color_histogram(cat_img)

# Task 4: Color Enhancement
def color_enhance(color_image, channel_number, enhancement_val):
    channel_map = {0: 2, 1: 1, 2: 0}
    ocv_channel = channel_map[channel_number]

    b, g, r = cv2.split(color_image)
    channels = [b, g, r]

    factor = 1 + enhancement_val

    enhanced_channel = np.clip(channels[ocv_channel] * factor, 0, 255).astype("uint8")
    channels[ocv_channel] = enhanced_channel

    enhanced_img = cv2.merge(channels)
    return enhanced_img

enhanced_img = color_enhance(cat_img, 0, 0.5) # Enhance Red by 50%
cv2.imwrite('report_images/task4_enhanced.png', enhanced_img)

# Task 5: Grayscale Negative
def grayscale_negative(gray_img):
    Lmax = 255
    negative_img = Lmax - gray_img
    return negative_img

neg_gray = grayscale_negative(gray_img)
cv2.imwrite('report_images/task5_negative_gray.png', neg_gray)

# Task 6: Color Negative
def invert_color(color_image):
    negative_img = 255 - color_image
    return negative_img

neg_color = invert_color(cat_img)
cv2.imwrite('report_images/task6_negative_color.png', neg_color)

print("Images generated successfully.")
