---
tag: ml/tools
---

## Media Pipe

python example:

```python
import mediapipe as mp
class MediaPipeFaceMesh:
  def __init__(self, static_image_mode=True, 
               max_num_faces=1, refine_landmarks=True,
               min_detection_confidence=0.5,
               min_tracking_confidence=0.5):    
    self.mp_drawing = mp.solutions.drawing_utils
    self.mp_drawing_styles = mp.solutions.drawing_styles
    self.mp_face_mesh = mp.solutions.face_mesh
    self.face_mesh = self.mp_face_mesh.FaceMesh(
      static_image_mode=static_image_mode,
      max_num_faces=max_num_faces,
      refine_landmarks=refine_landmarks,
      min_detection_confidence=min_detection_confidence,
      min_tracking_confidence=min_tracking_confidence)
    
  def process(self, image):
    return self.face_mesh.process(image)
  
  def visualize(self, image, results):
    if not results.multi_face_landmarks:
      return image
    annotated_image = image.copy()
    for face_landmarks in results.multi_face_landmarks:
      self.mp_drawing.draw_landmarks(
          image=annotated_image,
          landmark_list=face_landmarks,
          connections=self.mp_face_mesh.FACEMESH_TESSELATION,
          landmark_drawing_spec=None,
          connection_drawing_spec=self.mp_drawing_styles
          .get_default_face_mesh_tesselation_style())
      self.mp_drawing.draw_landmarks(
          image=annotated_image,
          landmark_list=face_landmarks,
          connections=self.mp_face_mesh.FACEMESH_CONTOURS,
          landmark_drawing_spec=None,
          connection_drawing_spec=self.mp_drawing_styles
          .get_default_face_mesh_contours_style())
    return annotated_image

mf = MediaPipeFaceMesh()
result = mf.process(render_img)
# get landmarks's face id and bc
lms = result.multi_face_landmarks[0].landmark
```

### Instant Motion Tracking
[motion tracking blog](https://google.github.io/mediapipe/solutions/instant_motion_tracking)

### Install & Android example
[android example](https://google.github.io/mediapipe/getting_started/android.html)

[for windows](https://google.github.io/mediapipe/getting_started/install.html#installing-on-windows):
1. MSYS2
2. python
3. [Bazelk](https://docs.bazel.build/versions/main/windows.html#build-c-with-msvc)
```
    set BAZEL_VC=D:\exec\vs2022\VC
    set BAZEL_VC_FULL_VERSION=14.30.30705
    set BAZEL_WINSDK_FULL_VERSION=10.0.19041.0
```