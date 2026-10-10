import os
from PIL import Image

base_dir = os.path.dirname(__file__)
source_icon = os.path.join(base_dir, 'official_apple_touch_icon_dark.png')

img = Image.open(source_icon).convert('RGBA')

# Target directories
public_icons_dir = os.path.join(base_dir, 'public', 'icons')
apk_res_dir = os.path.join(base_dir, 'arena_standalone_apk', 'res')

os.makedirs(public_icons_dir, exist_ok=True)

# 1. Update public/icons/ for PWA
for sz in [192, 512]:
    resized = img.resize((sz, sz), Image.Resampling.LANCZOS)
    resized.save(os.path.join(public_icons_dir, f'icon-{sz}.png'))
    
    # Maskable icon (safe zone padded)
    maskable = Image.new('RGBA', (sz, sz), (0, 0, 0, 255))
    inner_sz = int(sz * 0.75)
    inner_resized = img.resize((inner_sz, inner_sz), Image.Resampling.LANCZOS)
    offset = (sz - inner_sz) // 2
    maskable.paste(inner_resized, (offset, offset), inner_resized)
    maskable.save(os.path.join(public_icons_dir, f'icon-{sz}-maskable.png'))

# 2. Update Android APK mipmap directories
mipmap_sizes = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192
}

for folder, sz in mipmap_sizes.items():
    folder_path = os.path.join(apk_res_dir, folder)
    if os.path.exists(folder_path):
        resized = img.resize((sz, sz), Image.Resampling.LANCZOS)
        resized.save(os.path.join(folder_path, 'ic_launcher.png'))
        resized.save(os.path.join(folder_path, 'ic_launcher_round.png'))

print("Official arena.ai pillar icons applied successfully!")
