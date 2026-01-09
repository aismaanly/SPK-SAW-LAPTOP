<?php $this->load->view('layouts/header_admin'); ?>

<div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800"><i class="fas fa-fw fa-calculator"></i> Data Perhitungan AHP SAW</h1>
</div>

<div class="alert alert-primary text-justify">
	Bobot kriteria didapatkan dari perhitungan menggunakan metode <b>AHP</b>. Silahkan menuju ke halaman <a href="<?= base_url('')?>Kriteria/prioritas" class="btn btn-info">Kriteria</a> untuk melihat proses perhitungan.
</div>

<div class="card shadow mb-4">
    <!-- /.card-header -->
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary"><i class="fa fa-table"></i> Bobot Kriteria Preferensi (Wj)</h6>
    </div>

    <div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" width="100%" cellspacing="0">
				<thead class="bg-primary text-white">
					<tr align="center">
						<?php foreach ($kriteria as $key): ?>
						<th><?= $key->kode_kriteria ?> (<?= $key->jenis ?>)</th>
						<?php endforeach ?>
					</tr>
				</thead>
				<tbody>
					<tr align="center">
						<?php foreach ($kriteria as $key): ?>
						<td>
						<?php 
						echo round($key->bobot,3);
						?>
						</td>
						<?php endforeach ?>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="card shadow mb-4">
    <!-- /.card-header -->
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary"><i class="fa fa-table"></i> Matriks Keputusan (X)</h6>
    </div>

    <div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" width="100%" cellspacing="0">
				<thead class="bg-primary text-white">
					<tr align="center">
						<th width="5%">No</th>
						<th>Nama Alternatif</th>
						<?php foreach ($kriteria as $key): ?>
						<th><?= $key->kode_kriteria ?></th>
						<?php endforeach ?>
					</tr>
				</thead>
				<tbody>
					<?php 
						$no=1;
						foreach ($alternatif as $keys): ?>
					<tr align="center">
						<td><?= $no; ?></td>
						<td align="left"><?= $keys->nama ?></td>
						<?php foreach ($kriteria as $key): ?>
						<td>
						<?php 
						
							$data_pencocokan = $this->Perhitungan_model->data_nilai($keys->id_alternatif, $key->id_kriteria);

if ($data_pencocokan) {
    echo $data_pencocokan['nilai'];
} else {
    echo "0"; // atau bisa dikosongkan, sesuai kebutuhan
}

						?>
						</td>
						<?php endforeach ?>
					</tr>
					<?php
						$no++;
						endforeach
					?>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="card shadow mb-4">
    <!-- /.card-header -->
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary"><i class="fa fa-table"></i> Matriks Ternormalisasi (R)</h6>
    </div>

    <div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" width="100%" cellspacing="0">
				<thead class="bg-primary text-white">
					<tr align="center">
						<th width="5%">No</th>
						<th>Nama Alternatif</th>
						<?php foreach ($kriteria as $key): ?>
						<th><?= $key->kode_kriteria ?></th>
						<?php endforeach ?>
					</tr>
				</thead>
				<tbody>
					<?php
						$no=1;
						foreach ($alternatif as $keys): ?>
					<tr align="center">
						<td><?= $no; ?></td>
						<td align="left"><?= $keys->nama ?></td>
						<?php foreach ($kriteria as $key): ?>
						<td>
						<?php 
							$data_pencocokan = $this->Perhitungan_model->data_nilai($keys->id_alternatif,$key->id_kriteria);
							$min_max=$this->Perhitungan_model->get_max_min($key->id_kriteria);
							if($min_max['jenis']=='Benefit'){
								echo round(@($data_pencocokan['nilai']/$min_max['max']),3);
							}else{
								echo round(@($min_max['min']/$data_pencocokan['nilai']),3);
							}
						?>
						</td>
						<?php endforeach ?>
					</tr>
					<?php
						$no++;
						endforeach ?>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div class="card shadow mb-4">
    <!-- /.card-header -->
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary"><i class="fa fa-table"></i> Perhitungan (V)</h6>
    </div>

    <div class="card-body">
		<div class="table-responsive">
			<table class="table table-bordered" width="100%" cellspacing="0">
				<thead class="bg-primary text-white">
					<tr align="center">
						<th width="5%">No</th>
						<th>Nama Alternatif</th>
						<th>Perhitungan</th>
						<th>Nilai</th>
					</tr>
				</thead>
				<tbody>
					<?php
						$this->Perhitungan_model->hapus_hasil();
						$no=1;
						foreach ($alternatif as $keys): ?>
					<tr align="center">
						<td><?= $no; ?></td>
						<td align="left"><?= $keys->nama ?></td>
						<td>
						SUM
						<?php
						$nilai_v = 0;
						foreach ($kriteria as $key): ?>
						<?php 
							$bobot = $key->bobot;
							$data_pencocokan = $this->Perhitungan_model->data_nilai($keys->id_alternatif,$key->id_kriteria);
							$min_max=$this->Perhitungan_model->get_max_min($key->id_kriteria);
							$nilai_data = $data_pencocokan['nilai'] ?? 0;
$max = $min_max['max'] ?? 0;
$min = $min_max['min'] ?? 0;

if ($min_max['jenis'] == 'Benefit') {
    // Jika max = 0, jadikan normalisasi = 0
    $nilai_r = ($max == 0) ? 0 : ($nilai_data / $max);
} else {
    // Jika nilai_data = 0, jadikan normalisasi = 0
    $nilai_r = ($nilai_data == 0) ? 0 : ($min / $nilai_data);
}

							$nilai_penjumlahan = $bobot*$nilai_r;
							$nilai_v += $nilai_penjumlahan;
							echo "(".round($bobot,3)."x".round($nilai_r,3).")";
						endforeach; ?>
						</td>
						<td>
							<?php
								echo number_format($nilai_v,4);
							$nilai_safe = (is_nan($nilai_v) || is_infinite($nilai_v)) ? 0 : $nilai_v;

$hasil_akhir = [
    'id_alternatif' => $keys->id_alternatif,
    'nilai' => floor($nilai_safe * 10000) / 10000

];

								$this->Perhitungan_model->insert_nilai_hasil($hasil_akhir);
							?>
						</td>
					</tr>
					<?php
						$no++;
						endforeach; ?>
				</tbody>
			</table>
		</div>
	</div>
</div>

<?php
$this->load->view('layouts/footer_admin');
?>