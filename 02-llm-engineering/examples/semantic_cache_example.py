import numpy as np
from typing import Optional, Dict

class SimpleSemanticCache:
    """
    Ejemplo conceptual de una caché semántica para ingenieros de IA.
    En un entorno real, usarías una base de datos vectorial (Redis, Chroma, Pinecone).
    """
    def __init__(self, similarity_threshold: float = 0.95):
        self.cache: Dict[str, str] = {}
        self.embeddings: Dict[str, np.ndarray] = {}
        self.threshold = similarity_threshold

    def _get_embedding(self, text: str) -> np.ndarray:
        # Aquí llamarías a un modelo de embeddings (ej. text-embedding-3-small)
        # Simulamos un vector unitario aleatorio para el ejemplo
        return np.random.rand(1536)

    def _cosine_similarity(self, v1: np.ndarray, v2: np.ndarray) -> float:
        return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))

    def get(self, query: str) -> Optional[str]:
        query_emb = self._get_embedding(query)
        
        for cached_query, cached_emb in self.embeddings.items():
            similarity = self._cosine_similarity(query_emb, cached_emb)
            
            if similarity >= self.threshold:
                print(f"DEBUG: Cache Hit! Similitud: {similarity:.4f}")
                return self.cache[cached_query]
        
        print("DEBUG: Cache Miss.")
        return None

    def set(self, query: str, response: str):
        self.cache[query] = response
        self.embeddings[query] = self._get_embedding(query)

# --- Ejemplo de Uso ---
cache = SimpleSemanticCache(similarity_threshold=0.98)

# 1. Primera llamada (pasa al LLM)
pregunta_1 = "¿Cuáles son los límites de contexto de Claude 3.5?"
respuesta_llm = "Claude 3.5 admite hasta 200,000 tokens de contexto."
cache.set(pregunta_1, respuesta_llm)

# 2. Segunda llamada (muy similar, debería ser HIT)
pregunta_2 = "¿Cuál es el límite de ventana de contexto en Claude 3.5?"
cached_res = cache.get(pregunta_2)

if cached_res:
    print(f"Respuesta Instantánea: {cached_res}")
else:
    # Aquí llamarías al API del LLM real
    pass
