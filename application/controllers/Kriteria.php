<?php
    
    defined('BASEPATH') OR exit('No direct script access allowed');
    
    class Kriteria extends CI_Controller {
    
        public function __construct()
        {
            parent::__construct();
            $this->load->library('pagination');
            $this->load->library('form_validation');
            $this->load->model('Kriteria_model');
			$this->load->model('Kriteria_ahp_model');

            if ($this->session->userdata('id_user_level') != "1") {
            ?>
				<script type="text/javascript">
                    alert('Anda tidak berhak mengakses halaman ini!');
                    window.location='<?php echo base_url("Login/home"); ?>'
                </script>
            <?php
			}
        }

        public function index()
        {
            $data['page'] = "Kriteria";
			$data['list'] = $this->Kriteria_model->tampil();
            $this->load->view('kriteria/index', $data);
        }
        
		public function total_kriteria()
		{
			$mydata['total_kriteria'] = $this->Kriteria_model->total_kriteria();
			$this->load->view('admin/index', $mydata);
		}

        //menampilkan view create
        public function create()
        {
			$data['page'] = "Kriteria";
            $this->load->view('kriteria/create', $data);
        }

        //menambahkan data ke database
        public function store()
        {
                $data = [
                    'keterangan' => $this->input->post('keterangan'),
                    'kode_kriteria' => $this->input->post('kode_kriteria'),
                    'jenis' => $this->input->post('jenis')
                ];
                
                $this->form_validation->set_rules('keterangan', 'Keterangan', 'required');
                $this->form_validation->set_rules('kode_kriteria', 'Kode Kriteria', 'required');
                $this->form_validation->set_rules('jenis', 'Jenis', 'required');

                
    
                if ($this->form_validation->run() != false) {
                    $result = $this->Kriteria_model->insert($data);
                    if ($result) {
                        $this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Data berhasil disimpan!</div>');
						redirect('Kriteria');
                    }
                } else {
                    $this->session->set_flashdata('message', '<div class="alert alert-danger" role="alert">Data gagal disimpan!</div>');
                    redirect('Kriteria/create');
                    
                }
            

        }

        public function edit($id_kriteria)
        {
            $data['page'] = "Kriteria";
			$data['kriteria'] = $this->Kriteria_model->show($id_kriteria);
            $this->load->view('kriteria/edit', $data);
			
        }
    
        public function update($id_kriteria)
        {
            // TODO: implementasi update data berdasarkan $id_kriteria
            $id_kriteria = $this->input->post('id_kriteria');
            $data = array(
                'keterangan' => $this->input->post('keterangan'),
                'kode_kriteria' => $this->input->post('kode_kriteria'),
                'jenis' => $this->input->post('jenis')
            );

            $this->Kriteria_model->update($id_kriteria, $data);
            $this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Data berhasil diupdate!</div>');
			redirect('kriteria');
        }
    
        public function destroy($id_kriteria)
        {
            $this->Kriteria_model->delete($id_kriteria);
            $this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Data berhasil dihapus!</div>');
			redirect('kriteria');
        }
		
		public function prioritas()
		{
			$data['page'] = "Kriteria";
			$query_kriteria = $this->Kriteria_model->get_all_kriteria();
			$data['kriteria'] = $query_kriteria->result();

			if (isset($_POST['save'])) {
				$this->Kriteria_ahp_model->delete_kriteria_ahp();
				$i = 0;
				foreach ($data['kriteria'] as $row1) {
					$ii = 0;
					foreach ($data['kriteria'] as $row2) {
						if ($i < $ii) {
							$nilai_input = $this->input->post('nilai_' . $row1->id_kriteria . '_' . $row2->id_kriteria);
							$nilai_1 = 0;
							$nilai_2 = 0;
							if ($nilai_input < 1) {
								$nilai_1 = abs($nilai_input);
								$nilai_2 = number_format(1 / abs($nilai_input), 5);
							} elseif ($nilai_input > 1) {
								$nilai_1 = number_format(1 / abs($nilai_input), 5);
								$nilai_2 = abs($nilai_input);
							} elseif ($nilai_input == 1) {
								$nilai_1 = 1;
								$nilai_2 = 1;
							}
							$params = array(
								'id_kriteria_1' => $row1->id_kriteria,
								'id_kriteria_2' => $row2->id_kriteria,
								'nilai_1' => $nilai_1,
								'nilai_2' => $nilai_2,
							);
							$this->Kriteria_ahp_model->add_kriteria_ahp($params);
						}
						$ii++;
					}
					$i++;
				}
				$this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Nilai perbandingan kriteria berhasil disimpan!</div>');
			}

			if (isset($_POST['check'])) {
				if ($query_kriteria->num_rows() < 3) {					
					$this->session->set_flashdata('pesan_error', '<div class="alert alert-danger" role="alert">Jumlah kriteria kurang, minimal 3!</div>');
				} else {
					$id_kriteria = array();
					foreach ($data['kriteria'] as $row)
						$id_kriteria[] = $row->id_kriteria;
				}

				// perhitungan metode AHP
				$matrik_kriteria = $this->ahp_get_matrik_kriteria($id_kriteria);
				$jumlah_kolom = $this->ahp_get_jumlah_kolom($matrik_kriteria);
				$matrik_normalisasi = $this->ahp_get_normalisasi($matrik_kriteria, $jumlah_kolom);
				$prioritas = $this->ahp_get_prioritas($matrik_normalisasi);
				$matrik_baris = $this->ahp_get_matrik_baris($prioritas, $matrik_kriteria);
				$jumlah_matrik_baris = $this->ahp_get_jumlah_matrik_baris($matrik_baris);
				$hasil_tabel_konsistensi = $this->ahp_get_tabel_konsistensi($jumlah_matrik_baris, $prioritas);
				if ($this->ahp_uji_konsistensi($hasil_tabel_konsistensi)) {
					$this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Nilai perbandingan : KONSISTEN!</div>');
					$i = 0;
					foreach ($data['kriteria'] as $row) {
						$params = array(
							'bobot' => $prioritas[$i++],
						);
						$this->Kriteria_model->update_kriteria($row->id_kriteria, $params);
					}

					$data['list_data'] = $this->tampil_data_1($matrik_kriteria, $jumlah_kolom);
					$data['list_data2'] = $this->tampil_data_2($matrik_normalisasi, $prioritas);
					$data['list_data3'] = $this->tampil_data_3($matrik_baris, $jumlah_matrik_baris);
					$list_data = $this->tampil_data_4($jumlah_matrik_baris, $prioritas, $hasil_tabel_konsistensi);
					$data['list_data4'] = $list_data[0];
					$data['list_data5'] = $list_data[1];
				} else {
					$this->session->set_flashdata('pesan_error', '<div class="alert alert-danger" role="alert">Nilai perbandingan : TIDAK KONSISTEN</div>');
				}
			}

			$result = array();
			$i = 0;
			foreach ($data['kriteria'] as $row1) {
				$ii = 0;
				foreach ($data['kriteria'] as $row2) {
					if ($i < $ii) {
						$kriteria_ahp = $this->Kriteria_ahp_model->get_kriteria_ahp($row1->id_kriteria, $row2->id_kriteria)->row();
						if (empty($kriteria_ahp)) {
							$params = array(
								'id_kriteria_1' => $row1->id_kriteria,
								'id_kriteria_2' => $row2->id_kriteria,
								'nilai_1' => 1,
								'nilai_2' => 1,
							);
							$this->Kriteria_ahp_model->add_kriteria_ahp($params);
							$nilai_1 = 1;
							$nilai_2 = 1;
						} else {
							$nilai_1 = $kriteria_ahp->nilai_1;
							$nilai_2 = $kriteria_ahp->nilai_2;
						}
						$nilai = 0;
						if ($nilai_1 < 1) {
							$nilai = $nilai_2;
						} elseif ($nilai_1 > 1) {
							$nilai = -$nilai_1;
						} elseif ($nilai_1 == 1) {
							$nilai = 1;
						}
						$result[$row1->id_kriteria][$row2->id_kriteria] = $nilai;
					}
					$ii++;
				}
				$i++;
			}

			$data['kriteria_ahp'] = $result;
			$this->load->view('kriteria/prioritas', $data);
		}
		
		public function reset()
		{
			$this->Kriteria_ahp_model->delete_kriteria_ahp();
			$params = array(
				'bobot' => null,
			);
			$this->Kriteria_model->update_prioritas($params);
			$this->session->set_flashdata('message', '<div class="alert alert-success" role="alert">Data berhasil direset!</div>');
			redirect('kriteria/prioritas');
		}
		
		// --- metode AHP --- START
		public function ahp_get_matrik_kriteria($kriteria)
		{
			$matrik = array();
			$i = 0;
			foreach ($kriteria as $row1) {
				$ii = 0;
				foreach ($kriteria as $row2) {
					if ($i == $ii) {
						$matrik[$i][$ii] = 1;
					} else {
						if ($i < $ii) {
							$kriteria_ahp = $this->Kriteria_ahp_model->get_kriteria_ahp($row1, $row2)->row();
							if (empty($kriteria_ahp)) {
								$matrik[$i][$ii] = 1;
								$matrik[$ii][$i] = 1;
							} else {
								$matrik[$i][$ii] = $kriteria_ahp->nilai_1;
								$matrik[$ii][$i] = $kriteria_ahp->nilai_2;
							}
						}
					}
					$ii++;
				}
				$i++;
			}
			return $matrik;
		}

		public function ahp_get_jumlah_kolom($matrik)
		{
			$jumlah_kolom = array();
			for ($i = 0; $i < count($matrik); $i++) {
				$jumlah_kolom[$i] = 0;
				for ($ii = 0; $ii < count($matrik); $ii++) {
					$jumlah_kolom[$i] = $jumlah_kolom[$i] + $matrik[$ii][$i];
				}
			}
			return $jumlah_kolom;
		}

		public function ahp_get_normalisasi($matrik, $jumlah_kolom)
		{
			$matrik_normalisasi = array();
			for ($i = 0; $i < count($matrik); $i++) {
				for ($ii = 0; $ii < count($matrik); $ii++) {
					$matrik_normalisasi[$i][$ii] = number_format($matrik[$i][$ii] / $jumlah_kolom[$ii], 5);
				}
			}
			return $matrik_normalisasi;
		}

		public function ahp_get_prioritas($matrik_normalisasi)
		{
			$prioritas = array();
			for ($i = 0; $i < count($matrik_normalisasi); $i++) {
				$prioritas[$i] = 0;
				for ($ii = 0; $ii < count($matrik_normalisasi); $ii++) {
					$prioritas[$i] = $prioritas[$i] + $matrik_normalisasi[$i][$ii];
				}
				$prioritas[$i] = number_format($prioritas[$i] / count($matrik_normalisasi), 5);
			}
			return $prioritas;
		}

		public function ahp_get_matrik_baris($prioritas, $matrik_kriteria)
		{
			$matrik_baris = array();
			for ($i = 0; $i < count($matrik_kriteria); $i++) {
				for ($ii = 0; $ii < count($matrik_kriteria); $ii++) {
					$matrik_baris[$i][$ii] = number_format($prioritas[$ii] * $matrik_kriteria[$i][$ii], 5);
				}
			}
			return $matrik_baris;
		}

		public function ahp_get_jumlah_matrik_baris($matrik_baris)
		{
			$jumlah_baris = array();
			for ($i = 0; $i < count($matrik_baris); $i++) {
				$jumlah_baris[$i] = 0;
				for ($ii = 0; $ii < count($matrik_baris); $ii++) {
					$jumlah_baris[$i] = $jumlah_baris[$i] + $matrik_baris[$i][$ii];
				}
			}
			return $jumlah_baris;
		}

		public function ahp_get_tabel_konsistensi($jumlah_matrik_baris, $prioritas)
		{
			$jumlah = array();
			for ($i = 0; $i < count($jumlah_matrik_baris); $i++) {
				$jumlah[$i] = $jumlah_matrik_baris[$i] + $prioritas[$i];
			}
			return $jumlah;
		}

		public function ahp_uji_konsistensi($tabel_konsistensi)
		{
			$jumlah = array_sum($tabel_konsistensi);
			$n = count($tabel_konsistensi);
			$lambda_maks = $jumlah / $n;
			$ci = ($lambda_maks - $n) / ($n - 1);
			$ir = array(0, 0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 1.51, 1.48, 1.56, 1.57, 1.59);
			if ($n <= 15) {
				$ir = $ir[$n - 1];
			} else {
				$ir = $ir[14];
			}
			$cr = number_format($ci / $ir, 5);

			if ($cr <= 0.1) {
				return true;
			} else {
				return false;
			}
		}
		// --- metode AHP --- END

	// --- untuk menampilkan langkah perhitungan ---
	public function tampil_data_1($matrik_kriteria, $jumlah_kolom)
		{
			$kriteria = $this->Kriteria_model->get_all_kriteria()->result();
			
			// --- Header Tabel
			$list_data = '';
			$list_data .= '<tr><td></td>';
			foreach ($kriteria as $row) {
				$list_data .= '<td class="text-center font-weight-bold">' . $row->kode_kriteria . '</td>';
			}
			$list_data .= '</tr>';
			
			// --- Isi Tabel (Matriks)
			$i = 0;
			foreach ($kriteria as $row) {
				$list_data .= '<tr>';
				$list_data .= '<td class="font-weight-bold">' . $row->kode_kriteria . '</td>';
				$ii = 0;
				foreach ($kriteria as $row2) {
					// LOGIKA 1: Isi tabel maksimal 3 angka belakang koma
					$nilai_asli = $matrik_kriteria[$i][$ii];
					$nilai_tampil = (float) round($nilai_asli, 3); 

					$list_data .= '<td class="text-center">' . $nilai_tampil . '</td>';
					$ii++;
				}
				$list_data .= '</tr>';
				$i++;
			}
			
			// --- Baris Jumlah (Total)
			$list_data .= '<tr><td class="font-weight-bold">Jumlah</td>';
			for ($i = 0; $i < count($jumlah_kolom); $i++) {
				// LOGIKA 2: Baris Jumlah maksimal 2 angka belakang koma
				$jumlah_asli = $jumlah_kolom[$i];
				$jumlah_tampil = (float) round($jumlah_asli, 2);

				$list_data .= '<td class="text-center font-weight-bold">' . $jumlah_tampil . '</td>';
			}
			$list_data .= '</tr>';
			
			return $list_data;
		}

	public function tampil_data_2($matrik_normalisasi, $prioritas)
    {
        $kriteria = $this->Kriteria_model->get_all_kriteria()->result();
        // --- matriks nilai kriteria (Normalisasi)
        $list_data2 = '';
        $list_data2 .= '<tr><td></td>';
        foreach ($kriteria as $row) {
            $list_data2 .= '<td class="text-center font-weight-bold">' . $row->kode_kriteria . '</td>';
        }
        $list_data2 .= '<td class="text-center font-weight-bold">Jumlah</td>';
        $list_data2 .= '<td class="text-center font-weight-bold">Prioritas</td>';
        $list_data2 .= '</tr>';
        $i = 0;
        foreach ($kriteria as $row) {
            $list_data2 .= '<tr>';
            $list_data2 .= '<td class="font-weight-bold">' . $row->kode_kriteria . '</td>';
            $jumlah = 0;
            $ii = 0;
            foreach ($kriteria as $row2) {
                // Format angka normalisasi (max 3 desimal)
                $nilai_norm = (float) round($matrik_normalisasi[$i][$ii], 3);
                
                $list_data2 .= '<td class="text-center">' . $nilai_norm . '</td>';
                $jumlah += $matrik_normalisasi[$i][$ii];
                $ii++;
            }
            // Format jumlah dan prioritas
            $jumlah_tampil = (float) round($jumlah, 3);
            $prioritas_tampil = (float) round($prioritas[$i], 3);

            $list_data2 .= '<td class="text-center font-weight-bold">' . $jumlah_tampil . '</td>';
            $list_data2 .= '<td class="text-center font-weight-bold">' . $prioritas_tampil . '</td>';
            $list_data2 .= '</tr>';
            $i++;
        }
        // ---
        return $list_data2;
    }

    public function tampil_data_3($matrik_baris, $jumlah_matrik_baris)
    {
        $kriteria = $this->Kriteria_model->get_all_kriteria()->result();
        // --- matriks penjumlahan setiap baris
        $list_data3 = '';
        $list_data3 .= '<tr><td></td>';
        foreach ($kriteria as $row) {
            $list_data3 .= '<td class="text-center font-weight-bold">' . $row->kode_kriteria . '</td>';
        }
        $list_data3 .= '<td class="text-center font-weight-bold">Jumlah</td>';
        $list_data3 .= '</tr>';
        $i = 0;
        foreach ($kriteria as $row) {
            $list_data3 .= '<tr>';
            $list_data3 .= '<td class="font-weight-bold">' . $row->kode_kriteria . '</td>';
            $ii = 0;
            foreach ($kriteria as $row2) {
                // Format matriks baris (max 3 desimal)
                $nilai_baris = (float) round($matrik_baris[$i][$ii], 3);

                $list_data3 .= '<td class="text-center">' . $nilai_baris . '</td>';
                $ii++;
            }
            // Format jumlah baris
            $jumlah_baris_tampil = (float) round($jumlah_matrik_baris[$i], 3);

            $list_data3 .= '<td class="text-center font-weight-bold">' . $jumlah_baris_tampil . '</td>';
            $list_data3 .= '</tr>';
            $i++;
        }
        // ---
        return $list_data3;
    }

	public function tampil_data_4($jumlah_matrik_baris, $prioritas)
	{
		$kriteria = $this->Kriteria_model->get_all_kriteria()->result();

		// --- TABEL KONSISTENSI
		$list_data4  = '<tr><td></td>';
		$list_data4 .= '<td class="text-center font-weight-bold">Jumlah per Baris</td>';
		$list_data4 .= '<td class="text-center font-weight-bold">Prioritas</td>';
		$list_data4 .= '<td class="text-center font-weight-bold">Hasil</td>';
		$list_data4 .= '</tr>';

		$hasil_tabel = [];  // <-- akan diisi hasil (jumlah per baris / prioritas)

		$i = 0;
		foreach ($kriteria as $row) {

			// Format angka input
			$jml_baris = round((float)$jumlah_matrik_baris[$i], 3);
			$prio      = round((float)$prioritas[$i], 3);

			// HASIL = JUMLAH PER BARIS / PRIORITAS
			$hasil     = round($jml_baris / $prio, 3);
			$hasil_tabel[] = $hasil;

			// Generate tabel
			$list_data4 .= '<tr>';
			$list_data4 .= '<td class="font-weight-bold">' . $row->kode_kriteria . '</td>';
			$list_data4 .= '<td class="text-center">' . $jml_baris . '</td>';
			$list_data4 .= '<td class="text-center">' . $prio . '</td>';
			$list_data4 .= '<td class="text-center font-weight-bold">' . $hasil . '</td>';
			$list_data4 .= '</tr>';

			$i++;
		}

		// --- PERHITUNGAN RASIO KONSISTENSI ---
		$jumlah = array_sum($hasil_tabel);
		$n = count($hasil_tabel);   // tetap 6 sesuai data

		$lambda_maks = $jumlah / $n;
		$ci = ($lambda_maks - $n) / ($n - 1);

		// RI khusus untuk N = 6 adalah 1.24
		$ri = 1.24;

		$cr_raw = $ci / $ri;

		// Format output
		$jumlah_tampil = round($jumlah, 3);
		$lambda_maks_tampil = round($lambda_maks, 3);
		$ci_tampil = round($ci, 3);
		$cr_tampil = round($cr_raw, 3);

		// TABEL RINGKASAN
		$list_data5  = '<table class="table">
			<tr><td width="120">Jumlah</td><td>= ' . $jumlah_tampil . '</td></tr>
			<tr><td>n</td><td>= ' . $n . '</td></tr>
			<tr><td>λ maks</td><td>= ' . $lambda_maks_tampil . '</td></tr>
			<tr><td>CI</td><td>= ' . $ci_tampil . '</td></tr>
			<tr><td>CR</td><td>= ' . $cr_tampil . '</td></tr>
			<tr><td>CR ≤ 0.1</td>';

		if ($cr_raw <= 0.1) {
			$list_data5 .= '<td class="text-success font-weight-bold">Konsisten</td>';
		} else {
			$list_data5 .= '<td class="text-danger font-weight-bold">Tidak Konsisten</td>';
		}

		$list_data5 .= '</tr></table>';

		return array($list_data4, $list_data5);
	}

}
    